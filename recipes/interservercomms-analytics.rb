
name = node["chefservers"]["name"]

chefserver = search(:node, "name:#{name}-ChefServer").first
chefserverip = chefserver['cloud']['public_ipv4']
# chefserverip = chefserver["cloud"]["public_ipv4"]
command = "scp -pq ec2-user@#{chefserverip}:/tmp/opscode-analytics.tar /tmp"
execute command

# analyticsserver = search(:node, 'name:AnalyticsServer')
# analyticsserver.each do |svr|

    # analyticsserverip = svr["cloud"]["public_ipv4"]
    analyticsserverip = node["cloud"]["public_ipv4"]

    log "#{analyticsserverip}"

    # execute 'cat /tmp/opscode-analytics.tar | ssh  ec2-user@"#{analyticsserverip}" sudo tar -xzf - -C /'
    execute 'tar -xzf /tmp/opscode-analytics.tar - -C /'

    template '/etc/opscode-analytics/opscode-analytics.rb' do
      source 'opscode-analytics.rb.erb'
      owner 'root'
      group 'root'
      mode '0644'
      variables(
          :analyticsserverip => analyticsserverip
          )
      # notifies :run, 'execute[chef-server-ctl-stop]'
    end
# end

execute 'opscode-analytics-ctl preflight-check'
execute 'opscode-analytics-ctl reconfigure'
execute 'opscode-analytics-ctl test'

