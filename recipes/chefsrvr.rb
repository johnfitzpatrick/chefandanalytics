#
# Cookbook Name:: chefservers
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Need to run this due to error '/etc/opscode/pivotal.rb does not exist'

# execute 'chef-server-ctl reconfigure' do
#   action :run
# end

firstname = node["chefservers"]["chefuserfirstname"]
lastname = node["chefservers"]["chefuserlastname"]
username = node["chefservers"]["chefusername"]
password = node["chefservers"]["chefuserpassword"]
org = node["chefservers"]["defaultorg"]
email = node["chefservers"]["chefuseremail"]
orgfullname = node["chefservers"]["defaultorgfullname"]

setupcommand = "chef-server-ctl marketplace-setup -f #{firstname} -l #{lastname} -u #{username} -p #{password} -e #{email} -o #{org} -y"

execute setupcommand



