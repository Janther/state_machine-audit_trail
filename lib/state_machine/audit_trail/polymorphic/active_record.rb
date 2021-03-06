# This is the class that does the actual logging.
# We need one of these per ORM

class StateMachine::AuditTrail::Polymorphic::ActiveRecord < StateMachine::AuditTrail::Polymorphic

  # Public writes the log to the database
  #
  # object: the object being watched by the state_machine observer
  # event:  the event being observed by the state machine
  # from:   the state of the object prior to the event
  # to:     the state of the object after the event
  def log(object, event, from, to, timestamp = Time.now)
    transition_class.create(auditable_id: object.id, auditable_type: object_type(object), event: event, from: from, to: to)
  end
end
