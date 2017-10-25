#!/opt/puppetlabs/puppet/bin/ruby
require 'puppet'
require 'json'

params = JSON.parse(STDIN.read)
type = params['type']

begin
  s = Puppet::Type.type(type)
rescue
  puts "Type #{type} is not a valid puppet resource"
  exit 1
end

valid = []

s.providers.each do | prov |
  if s.validprovider?(prov)
    valid.push(prov.to_s)
  end
end

puts valid.to_json
