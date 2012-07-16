class StateMachineTransition < ActiveRecord::Base
  belongs_to :auditables, :polymorphic => true
end
