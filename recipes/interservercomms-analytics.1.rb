
name = node["chefservers"]["name"]



# remote_file '/tmp/opscode-analytics.tar' do
#   source lazy '{ node["chefservers"]["chefpublicip"] }''/tmp/opscode-analytics.tar'
#   owner 'ec2-user'
#   group 'ec2-user'
#   mode '0644'
#   action :create
# end

# chefserver = search(:ipdatabag, 'name:chefpublicip')
    # chefip = data_bag_item('chefip', node['ec2']['public_ipv4'])

# chefserver.each do |svr|
# chefpublicip = chefserver['ec2']['public_ipv4']


chefip = node["chefservers"]["chefpublicip"]
# chefip = lazy { node["chefservers"]["chefpublicip"] }
# copycommand = "scp -p ec2-user@#{chefip}:/tmp/opscode-analytics.tar /tmp"
# execute copycommand

execute 'copyfile' do
  command lazy { "scp -p ec2-user@#{chefip}:/tmp/opscode-analytics.tar /tmp" }
  action :run
end


  # execute 'copyoveranalytics' do
  #   command 'scp -p ec2-user@"#{chefpublicip}":/tmp/opscode-analytics.tar /tmp'
  #   action :run
  # end
  
  # execute 'scp -p ec2-user@chefpublicip:/tmp/opscode-analytics.tar /tmp'
  
# end


analyticsserver = search(:node, 'name:AnalyticsServer')
analyticsserver.each do |svr|

    analyticsserverip = svr["cloud"]["public_ipv4"]

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
end

execute 'opscode-analytics-ctl preflight-check'
execute 'opscode-analytics-ctl reconfigure'
execute 'opscode-analytics-ctl test'

