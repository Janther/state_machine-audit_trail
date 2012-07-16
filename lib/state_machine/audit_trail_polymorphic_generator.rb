require 'rails/generators'

class StateMachine::AuditTrailGenerator < ::Rails::Generators::Base
  
  source_root File.join(File.dirname(__FILE__), 'templates')
  
  def create_model
    record do |m|
      m.file "models/state_machine_transitions.rb", "app/models/state_machine_transitions.rb"
      m.migration_template "migrate/create_state_machine_transitions.rb", "db/migrate"
    end
  end

  def file_name
    "create_state_machine_transitions"
  end
end
