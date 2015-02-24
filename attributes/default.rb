default['postgresql']['database_root_password'] = 'postgres'
default['postgresql']['config']['listen_addresses'] = '*'
default['chef-postgresql']['databases'] = { 'db1' => { 'user' => 'user1', 'password' => 'pwd1' } , 'db2' => { 'user' => 'user2' , 'password' => 'pwd2' } }
default['chef-postgresql']['pg_hba'] = [
  {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
  {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'ident'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '192.168.0.1/32', :method => 'md5'}
]
