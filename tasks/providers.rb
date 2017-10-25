#!/opt/puppetlabs/puppet/bin/ruby
require 'puppet'

if ARGV.length != 1
  puts "Usage: #{$0} <type of puppet resource>"
  puts "#{$0} service"
  exit 2
end

type = ARGV[0]

s = Puppet::Type.type(type)
valid = []

s.providers.each do | prov |
  if s.validprovider?(prov)
    valid.push(prov.to_s)
  end
end

puts valid
