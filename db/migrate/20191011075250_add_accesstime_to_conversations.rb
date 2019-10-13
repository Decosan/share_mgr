class AddAccesstimeToConversations < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :accesstime, :datetime, default: -> { 'NOW()' }
  end
end
