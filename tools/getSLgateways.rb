#!/bin/env ruby
#(c) Softlayer; Alexey Zilber - AlexeyZilber@gmail.com
require 'rubygems'
require 'pp'
require 'softlayer_api'

backend_iface = 'bond0'

file_store = '/tmp/routes'
 
account_service = SoftLayer::Service.new("SoftLayer_Account",
    :username => "your_account",                                                                                                                                             
    :api_key => "your_api_key")
 
# Retrieve items related to hardware.
#
# Operating system, operating system passwords, all network components, the
# datacenter the server is located in, and the number of processors in each
# server.

object_mask = {
     "hardware" => {
        "fullyQualifiedDomainName" => "", 
        "primaryBackendNetworkComponent" => {
            "primarySubnet" => {
               "gateway" => "" 
            }
        }
      }
}

begin 
   account = account_service.object_mask(object_mask).getHardware
rescue Exception => exception
    puts "Unable to retrieve account information: #{exception}"
end


account.each_with_index { |row, index|
	puts "Creating #{index} -> " + "#{row['fullyQualifiedDomainName']} -> gw: #{row['primaryBackendNetworkComponent']['primarySubnet']['gateway']}"

#Create the route file
        rfile = File.new(file_store + "/" + "#{row['fullyQualifiedDomainName'].split('.').first}.route-" + backend_iface, "w")
	printf(rfile,"10.0.0.0/8 via %s\n",row['primaryBackendNetworkComponent']['primarySubnet']['gateway'])
	rfile.chmod( 0644 )
	rfile.close

#Create the route script
	rfile = File.new(file_store + "/" + "#{row['fullyQualifiedDomainName'].split('.').first}.runme.sh", "w")
	printf(rfile,"route add -net 10.0.0.0/8 gw %s\n",row['primaryBackendNetworkComponent']['primarySubnet']['gateway'])
	rfile.chmod( 0755 )
	rfile.close
	
}

