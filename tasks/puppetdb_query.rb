#!/opt/puppetlabs/puppet/bin/ruby

# Ranjit helped creating this beauty
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
  puts JSON.pretty_generate puppetdb_query(query)
  exit 0
rescue Puppet::Error => e
  puts JSON.pretty_generate "{ status: 'failure', error: e.message }".to_json
  exit 1
end
