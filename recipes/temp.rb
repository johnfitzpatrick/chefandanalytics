require 'chef/provisioning/aws_driver'

name = "YOURNAME"

region = node["chefservers"]["region"]

with_driver "aws::#{region}" do
# ports = [22, 80, 443, 5672]
# ports.each do |port|
#   aws_security_group "#{name}-#{port}" do
#     inbound_rules [{:ports => #{port}, :protocol => :tcp, :sources => ['0.0.0.0/0'] }]
#   end
# end

node["chefservers"]["ports"].each do |portname, port|
  aws_security_group "#{name}-#{portname}-secgroup" do
    inbound_rules [{:ports => #{port}, :protocol => :tcp, :sources => ['0.0.0.0/0'] }]
  end
end

# This key needs created locally. This resource uploads it.
aws_key_pair '#{name}-aws-key' do
  private_key_path "~/.ssh/#{name}-aws-key.pem"
  public_key_path "~/.ssh/#{name}-aws-key.pub"
  overwrite false # Set to true if you want to regenerate this each chef run
end

with_machine_options({
  :ssh_username => "root",
  :image_id => "node[chefservers][chefserverami]",
  :bootstrap_options => {
    :instance_type => node["chefservers"]["chefserverinstance]",
    :security_group_ids => [ "#{name}-ssh","#{name}-http"],
    :key_name => "#{name}-aws-key"
  },
  :convergence_options => {
    :chef_version => "12.2.1"
  }
})


# # declare security groups
# aws_security_group "#{name}-ssh" do
#   inbound_rules [{:ports => 22, :protocol => :tcp, :sources => ['0.0.0.0/0'] }]
# end

# aws_security_group "#{name}-http" do
#   inbound_rules [{:ports => 80, :protocol => :tcp, :sources => ['0.0.0.0/0'] }]
# end

# specify what's needed to create a machine
# with_machine_options({
#   :ssh_username => "root",
#   :image_id => "ami-b6bdde86",
#   :bootstrap_options => {
#     :instance_type => "t1.micro",
#     :security_group_ids => [ "#{name}-ssh","#{name}-http"],
#     :key_name => "aws-popup-chef"
#   },
#   :convergence_options => {
#     :chef_version => "12.2.1"
#   }
# })

# declare a machine to act as our web server
machine "#{name}-ChefServer" do
  recipe "default"
  tag "ChefServer"
  converge true
end


end