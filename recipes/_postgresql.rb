#
# Cookbook Name:: _postgresql
# Recipe:: _postgresql
#
# Copyright (C) 2015 Stephane LII
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
node.set['postgresql']['password']['postgres'] = node['postgresql']['database_root_password']
node.set['postgresql']['config']['listen_addresses'] = node['postgresql']['config']['listen_addresses']

node.set['postgresql']['pg_hba'] =[]
node['chef-postgresql']['pg_hba'].each_index do |index|
   node.set['postgresql']['pg_hba'][index] = {
      :type => node['chef-postgresql']['pg_hba'][index]['type'],
      :db => node['chef-postgresql']['pg_hba'][index]['db'],
      :user => node['chef-postgresql']['pg_hba'][index]['user'],
      :addr => node['chef-postgresql']['pg_hba'][index]['addr'],
      :method => node['chef-postgresql']['pg_hba'][index]['method']
   }

end

# install the database software
include_recipe 'postgresql::server'

# create the database
include_recipe 'database::postgresql'

postgresql_connection_info = {
   host: '127.0.0.1',
   port: 5432,
   username: 'postgres',
   password: node['postgresql']['database_root_password']
}


node['chef-postgresql']['databases'].each_pair do |database,params|

   postgresql_database database do
      connection postgresql_connection_info
      action :create
   end

end

node['chef-postgresql']['databases'].each_pair do |database,params|

   postgresql_database_user params['user'] do
      connection postgresql_connection_info
      password  params['password']
      action :create
   end

   postgresql_database_user  params['user'] do
      connection postgresql_connection_info
      password params['password']
      database_name database
      action :grant
   end
end
