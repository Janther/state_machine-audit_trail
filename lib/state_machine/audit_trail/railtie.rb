class StateMachine::AuditTrail::Railtie < ::Rails::Railtie
  generators do
    require 'state_machine/audit_trail_generator'
    require 'state_machine/audit_trail_polymorphic_generator'
  end
end
