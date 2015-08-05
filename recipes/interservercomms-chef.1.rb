name = node["chefservers"]["name"]

execute 'chef-server-ctl-stop' do
  command 'chef-server-ctl stop'
  action :run
end

# chefserver = search(:node, "name:ChefServer")
# chefserver.first do |svr|
	# chefserverfqdn = chefserver["fqdn"]
	# chefpublicdns  = chefserver["cloud"]["public_hostname"]
 #    analyticsfqdn  = chefserver["fqdn"]

	chefserverfqdn = node["fqdn"]
    chefpublicip   = node['ec2']['public_ipv4']
	chefpublicdns  = node["cloud"]["public_hostname"]
    analyticsfqdn  = node["fqdn"]

    node.default["chefservers"]["chefpublicip"] = node['ec2']['public_ipv4']

	# ruby_block 'setipattribute' do
	#   block do
	# 	node.default["chefservers"]["chefpublicip"] = node['ec2']['public_ipv4']
	#   end
	# end

    node.default["chefservers"]["chefpublicip"] = node['ec2']['public_ipv4']

 node.set["chefservers"]["chefpublicip"]

		# chef_data_bag_item  "name" do
		# 	chef_server chefzero://localhost:8889
		# 	raw_json { "id" => node['ec2']['public_ipv4'] }
		# 	action :create
		# end


  #   # ipdatabag = data_bag('ipdatabag')
  #   # ip = data_bag_item('ipdatabag', ipaddress)

	 #  ip_hash = { "id" => node['ec2']['public_ipv4'] }
	 #  # ip_hash = { "id" => node['fqdn'], "chefpublicip" => node['ec2']['public_ipv4'] }
	 #  databag_item = Chef::DataBagItem.new
	 #  databag_item.data_bag("chefip")
	 #  databag_item.raw_data = ip_hash
	 #  databag_item.save
	 #  ipdatabag = data_bag_item('chefip', node['ec2']['public_ipv4'])

	# chefserverfqdn = search(:node, 'name:"#{name}-ChefServer"').first["fqdn"]
	# chefpublicdns =  search(:node, 'name:"#{name}-ChefServer"').first[:ec2][:public_hostname]
	# analyticsfqdn = search(:node, 'name:"#{name}-AnalyticsServer"').first["fqdn"]

	template '/etc/opscode/chef-server.rb' do
	  source 'chef-server.rb.erb'
	  owner 'root'
	  group 'root'
	  mode '0644'
	  variables(
	      :chefserverfqdn => chefserverfqdn,
	      :chefpublicdns => chefpublicdns,
	      :analyticsfqdn => analyticsfqdn
	      )
	  notifies :run, 'execute[chef-server-ctl-stop]'
	end

# end

#commented out as a Troubleshooting time saver
# execute 'sudo chef-server-ctl reconfigure'
# execute 'sudo chef-server-ctl restart'
# execute 'sudo opscode-manage-ctl reconfigure'

#Create tar file 
execute 'sudo tar -czvf /tmp/opscode-analytics.tar /etc/opscode-analytics'


