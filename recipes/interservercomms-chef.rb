name = node["chefservers"]["name"]

execute 'chef-server-ctl-stop' do
  command 'chef-server-ctl stop'
  action :run
end

analyticsfqdn  = search(:node, 'name:AnalyticsServer').first["fqdn"]
chefserverfqdn = node["fqdn"]
chefpublicdns  = node["ec2"]["public_hostname"]

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

# #commented out as a Troubleshooting time saver
execute 'sudo chef-server-ctl reconfigure'
execute 'sudo chef-server-ctl restart'
execute 'sudo opscode-manage-ctl reconfigure'

# #Create tar file 
execute 'sudo tar -czvf /tmp/opscode-analytics.tar /etc/opscode-analytics'


