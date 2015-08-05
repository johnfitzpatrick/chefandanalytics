#
# Cookbook Name:: chefandanalytics
# Recipe:: analytics
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

service 'selinux' do
  action [:disable]
end

package 'wget'
# execute 'wget node["chefservers"]["analyticsrpm"]'
dpkg_package 'node["chefservers"]["analyticsrpm"]'


