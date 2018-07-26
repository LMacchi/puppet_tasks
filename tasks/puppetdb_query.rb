#!/opt/puppetlabs/puppet/bin/ruby

require 'puppet'
Puppet.initialize_settings
begin
  require 'puppet/util/puppetdb'
rescue LoadError
  raise 'PuppetDB utilities not found.  Is this the PuppetDB server?'
end

query = ENV['PT_query']

def puppetdb_query(query)
  Puppet::Util::Puppetdb.query_puppetdb(query)
end

begin
  puts Puppet::Util::Puppetdb.query_puppetdb(query).to_json
  exit 0
rescue Puppet::Error => e
  puts({ status: 'failure', error: e.message }.to_json)
  exit 1
end
