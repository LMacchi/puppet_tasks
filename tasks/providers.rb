#!/opt/puppetlabs/puppet/bin/ruby
require 'puppet'

params = JSON.parse(STDIN.read)
type = params['type']

s = Puppet::Type.type(type)
valid = []

s.providers.each do | prov |
  if s.validprovider?(prov)
    valid.push(prov.to_s)
  end
end

puts valid
