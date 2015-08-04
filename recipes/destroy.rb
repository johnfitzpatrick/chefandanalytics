require 'chef/provisioning/aws_driver'

name = node["chefservers"]["name"]
region = node["chefservers"]["region"]

with_driver "aws::#{region}"

#machine_batch do
#  machines  "#{name}-ChefServer"
#  action :destroy
#end

  machine "#{name}-ChefServer" do
    action :destroy
  end

  execute 'sleepytime' do
    command 'sleep 5'
    action :run
  end

	node["chefservers"]["ports"].each do |portname, port|
	thissecgrp = "#{name}-#{portname}-secgroup"
    aws_security_group thissecgrp do
    	action :destroy
    end
end