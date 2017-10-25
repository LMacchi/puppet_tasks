#!/opt/puppetlabs/puppet/bin/ruby
require 'puppet'
require 'json'

params = JSON.parse(STDIN.read)
type = params['type']

s = Puppet::Type.type(type)
valid = []

begin
  providers = s.providers
rescue
  puts "Type #{type} is not a valid Puppet resource"
  exit 1
end

providers.each do | prov |
  if s.validprovider?(prov)
    valid.push(prov.to_s)
  end
end

puts valid.to_json
exit 0
