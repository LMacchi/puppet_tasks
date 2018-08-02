#!/opt/puppetlabs/puppet/bin/ruby

require 'puppet'
require 'puppet/agent'
require 'puppet/agent/disabler'

command = ENV['PT_command']
message = ENV['PT_message'] || 'Puppet agent disabled via task'

Puppet.initialize_settings
include Puppet::Agent::Disabler

def get_status
  disabled? ? "disable" : "enable"
end

status = get_status

# If agent is already in desired status, do nothing
if command == status
  puts "Puppet agent is already #{command}d"
  exit 0
# If status requested, display it and exit
elsif command == 'status'
  puts "Puppet agent is #{status}d"
  exit 0
# If agent is not in desired status, switch it
else
  begin
    command == 'enable' ? enable : disable(message)
    puts "Puppet agent is now #{command}d"
    exit 0
  rescue Puppet::Error => e
    puts JSON.pretty_generate "{ status: 'failure', error: e.message }".to_json
    exit 1
  end
end
