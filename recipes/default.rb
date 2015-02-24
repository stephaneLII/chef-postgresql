#
# Cookbook Name:: chef-postresql
# Recipe:: default
#
# Copyright (C) 2015 Stephane LII
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apt::default"
include_recipe 'chef-postgresql::_postgresql'
