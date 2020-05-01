class AddIndexToEventsTitle < ActiveRecord::Migration[5.1]
  def change
    add_index :events, :title, unique: true
  end
end
