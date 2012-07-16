# this class inserts the appropriate hooks into the state machine.
# it also contains functions to instantiate an object of the "transition_class"
# the transition_class is the class for the model which holds the audit_trail

module StateMachine::AuditTrail::TransitionAuditing
  attr_accessor :transition_class_name
  
  # Public tells the state machine to hook in the appropriate before / after behaviour
  #
  # options: a Hash of options. keys that are used are :to => CustomTransitionClass 
  def store_audit_trail(options = {})
    state_machine = self
    state_machine.transition_class_name = (options[:to] || default_transition_class_name(options[:polymorphic])).to_s
    state_machine.after_transition do |object, transition|
      state_machine.audit_trail(options[:polymorphic]).log(object, transition.event, transition.from, transition.to)
    end

    state_machine.owner_class.after_create do |object|
      if !object.send(state_machine.attribute).nil?
        state_machine.audit_trail(options[:polymorphic]).log(object, nil, nil, object.send(state_machine.attribute))
      end
    end
  end

  # Public returns an instance of the class which does the actual audit trail logging
  def audit_trail(polymorphic = false)
    if polymorphic
      @transition_auditor ||= StateMachine::AuditTrail::Polymorphic.create_for_transition_class(transition_class)
    else
      @transition_auditor ||= StateMachine::AuditTrail::Backend.create_for_transition_class(transition_class)
    end
  end

  private

  def transition_class
    @transition_class ||= transition_class_name.constantize
  end

  def default_transition_class_name(polymorphic = false)
    if polymorphic
      "StateMachineTransition"
    else
      "#{owner_class.name}#{attribute.to_s.camelize}Transition"
    end
  end
end
