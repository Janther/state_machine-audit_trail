class CreateStateMachineTransitions < ActiveRecord::Migration
  def self.up
    create_table :state_machine_transitions do |t|
      t.integer :auditable_id, :null => false
      t.string  :auditable_type, :null => false, :limit => 20
      t.string  :event
      t.string  :from
      t.string  :to
      t.string  :created_at
    end

    add_index :state_machine_transitions, [ :auditable_id, :auditable_type ], :name => 'by_auditable'
  end

  def self.down
    drop_table :state_machine_transitions
  end
end
