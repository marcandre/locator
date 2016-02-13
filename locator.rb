#!/usr/bin/env ruby
mac_address = 'Mac Address Here!'

module Regex
  IP = /(?:\d{1,3}\.){3}\d{1,3}/
  MAC = /(?:[0-9a-f]{1,2}:){5}[0-9a-f]{1,2}/
end

def request_ip
  puts "What is the IP address of the device? (e.g.  192.168.1.69 )"
  ip = gets.strip
  unless /^#{Regex::IP}$/ =~ ip
    puts "This is not a valid IP address"
    ip = request_ip
  end
  ip
end

def ip_to_mac(ip)
  m = `arp -a`.match(/#{ip}\) at (#{Regex::MAC})/)
  raise "Sorry, could not find any device at ip #{ip}" unless m
  m[1]
end

def lookup_ip(ip)
  puts "Looking for IP address '#{ip}'"
  mac = ip_to_mac(ip)
  puts "Mac address found: #{mac}"
  puts "Replace the 'Mac Address Here!' in second line of the script with '#{mac}'"
end

def mac_to_ip(mac)
  m = `arp -a`.match(/(#{Regex::IP})\) at #{mac}/)
  raise "Sorry, could not find any device with mac address #{mac} on the network" unless m
  m[1]
end

def locate(mac)
  puts "Looking for Mac address '#{mac}'"
  ip = mac_to_ip(mac)
  puts "IP address found: #{ip}"
  `open http://#{ip}`
end

def run
  case ARGV[0]
  when Regex::MAC
    locate(ARGV[0])
  when Regex::IP
    lookup_ip(ARGV[0])
  when nil
    if mac_address == 'Mac Address Here!'
      lookup_ip(request_ip)
    else
      locate(mac_address)
    end
  else
    raise "'#{ARGV[0]}' isn't a valid mac or ip address. Mac address look like 1b:44:55:de:a1:69, IP address like 192.168.1.69"
  end
end

begin
  run
rescue Exception => e
  puts e
  exit 1
end
