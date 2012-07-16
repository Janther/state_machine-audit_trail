require 'rails/generators'

class StateMachine::AuditTrailPolymorphicGenerator < ::Rails::Generators::Base
  
  source_root File.join(File.dirname(__FILE__), 'templates')

  argument :table_name, :default => 'state_machine_transitions'

  def create_model
    @model_name
    record do |m|
      m.file "models/state_machine_transition.rb", "app/models/state_machine_transition.rb"
      m.migration_template "migrate/create_state_machine_transitions.rb", "db/migrate"
    end
  end

  def file_name
    "create_state_machine_transitions"
  end
end
