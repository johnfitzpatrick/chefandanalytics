require 'chef/provisioning/aws_driver'

# #Need to set "~/.aws/config" like this
# [default]
# aws_access_key_id = AKIAAABBCCDDEEFFGGHH
# aws_secret_access_key = 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

name = node["chefservers"]["name"]
region = node["chefservers"]["region"]

# with_driver "aws::#{region}" do
with_driver "aws::#{region}" do

  aws_security_group "#{name}-secgroup" do
    inbound_rules '0.0.0.0/0' => [ 22, 80, 443, 5672 ]
  end

  execute 'sleepytime' do
    command 'sleep 3'
    action :run
  end

  key = node["chefservers"]["sshkey"]

 machine_batch do
    # Create Chef Server
          machine "#{name}-ChefServer" do
            machine_options(
              :image_id => node["chefservers"]["chefserverami"],
              :bootstrap_options => {
                 :instance_type => node["chefservers"]["chefserverinstance"],
                 :security_group_ids => "#{name}-secgroup",
                 :key_name => "#{key}"},
              :convergence_options => {
              :chef_version => "12.2.1"
                },
              ssh_username: "ec2-user",
              sudo: true,
              )
            recipe 'chefandanalytics::chefsrvr'
            action :converge
            tag "#{name}-ChefServer"
          end

          # Create Analytics Server
            machine "#{name}-AnalyticsServer" do
              machine_options(
                :image_id => node["chefservers"]["analyticsami"],
                :bootstrap_options => {
                   :instance_type => node["chefservers"]["analyticsinstance"],
                   :security_group_ids => "#{name}-secgroup",
                   :key_name => "#{key}"},
                :convergence_options => {
                :chef_version => "12.2.1"
                  },
                ssh_username: "ec2-user",
                sudo: true,
                )
              # recipe 'chefandanalytics::analytics'
              action :setup
              tag "#{name}-AnalyticsServer"
            end
  end



# machine_batch do
  machine "#{name}-ChefServer" do
    recipe 'chefandanalytics::interservercomms-chef'
    # action :converge_only
  end

  machine "#{name}-AnalyticsServer" do
    recipe 'chefandanalytics::interservercomms-analytics'
    # action :converge_only
  end
# end
end
log 'your string to log'
