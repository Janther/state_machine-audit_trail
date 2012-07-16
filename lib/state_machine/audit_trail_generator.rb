require 'rails/generators'

class StateMachine::AuditTrailGenerator < ::Rails::Generators::Base
  
  source_root File.join(File.dirname(__FILE__), 'templates')
  
  argument :source_model,     :default => ''
  argument :state_attribute,  :default => 'state'
  argument :transition_model, :default => ''


  def create_model
    if source_model == ''
      record do |m|
        m.file "models/state_machine_transitions.rb", "app/models/state_machine_transitions.rb"
        m.migration_template "migrate/create_state_machine_transitions.rb", "db/migrate", name: :create_state_machine_transitions
      end
    else
      Rails::Generators.invoke('model', [transition_class_name, "#{source_model.tableize.singularize}:references", "event:string", "from:string", "to:string", "created_at:timestamp", '--no-timestamps', '--fixture=false'])
    end
  end
  
  protected
  
  def transition_class_name
    transition_model.blank? ? "#{source_model.camelize}#{state_attribute.camelize}Transition" : transition_model
  end
end
