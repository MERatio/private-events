class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.belongs_to :attendee
      t.belongs_to :event

      t.timestamps
    end
  end
end
