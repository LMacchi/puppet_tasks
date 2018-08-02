#!/opt/puppetlabs/puppet/bin/ruby

require 'puppet'
require 'puppet/agent'
require 'puppet/agent/disabler'

command = ENV['PT_command']

Puppet.initialize_settings
include Puppet::Agent::Disabler

def get_status
  disabled? ? "disable" : "enable"
end

if command == get_status
  puts "Puppet agent is already #{command}d"
  exit 0
else
  begin
    command == 'enable' ? enable : disable
    puts "Puppet agent is now #{command}d"
    exit 0
  rescue Puppet::Error => e
    puts JSON.pretty_generate "{ status: 'failure', error: e.message }".to_json
    exit 1
  end
end
