#Ports
default["chefservers"]["ports"]["http"]     = 80
default["chefservers"]["ports"]["https"]    = 443
default["chefservers"]["ports"]["ssh"]      = 22
default["chefservers"]["ports"]["rabbitmq"] = 5672

#Region
default["chefservers"]["region"] = "eu-west-1"

#AMIs & Instance types
default["chefservers"]["chefserverami"] = "ami-fa9edc8d"
default["chefservers"]["analyticsami"]  = "ami-ede0739a"
default["chefservers"]["chefserverinstance"]  = "t2.medium"
default["chefservers"]["analyticsinstance"]  = "t2.large"

#Key
# Without the .pub. e.g. for '~/.ssh/mykey.pub', put 'mykey'.  This should already be created on workstation.	
##REPLACE WITH "mykey"
default["chefservers"]["sshkey"] = "jhn-euwest"

# Inital org & user details
default["chefservers"]["defaultorg"] = "myorg"
default["chefservers"]["defaultorgfullname"] = "my-chef-org"
default["chefservers"]["chefusername"] = "myuser"
default["chefservers"]["chefuserfirstname"] = "John"
default["chefservers"]["chefuserlastname"] = "Fitzpatrick"
default["chefservers"]["chefuseremail"] = "fitz@chef.io"
default["chefservers"]["chefuserpassword"] = "mypassword"

# Unique Identifer
default["chefservers"]["name"] = "jhnftztest"

# Analytics Package (Need to rightclick the download link from http://downloads.chef.io/analytics/redhat/#/ and copy the URL)
# This is clunky - must be a better way of doing this
default["chefservers"]["analyticsrpm"] = "https://web-dl.packagecloud.io/chef/stable/packages/el/5/opscode-analytics-1.1.5-1.el5.x86_64.rpm"