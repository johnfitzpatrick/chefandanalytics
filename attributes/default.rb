#Ports
default["chefservers"]["ports"]["http"]     = 80
default["chefservers"]["ports"]["https"]    = 443
default["chefservers"]["ports"]["ssh"]      = 22
default["chefservers"]["ports"]["rabbitmq"] = 5672

#AMIs
default["chefservers"]["chefserverami"] = "ami-fa9edc8d"
default["chefservers"]["chefserverinstance"]  = "t2.medium"

#Region
default["chefservers"]["region"] = "eu-west-1"

#Key
# Without the .pub. e.g. for '~/.ssh/mykey.pub', put 'mykey'.  This should already be created on workstation.	
##REPLACE WITH "mykey"
default["chefservers"]["sshkey"] = "jhn-euwest"


#Instance types
default["chefservers"]["analyticsami"]  = "ami-ede0739a"
default["chefservers"]["analyticsinstance"]  = "t2.large"


# Inital org details
default["chefservers"]["defaultorg"] = "myorg"
default["chefservers"]["defaultorgfullname"] = "my-chef-org"

# Chef User
default["chefservers"]["chefusername"] = "myuser"
default["chefservers"]["chefuserfirstname"] = "John"
default["chefservers"]["chefuserlastname"] = "Fitzpatrick"
default["chefservers"]["chefuseremail"] = "fitz@chef.io"
default["chefservers"]["chefuserpassword"] = "P@55w0rd!"

# Unique Identifer
default["chefservers"]["name"] = "jhnftztest"
