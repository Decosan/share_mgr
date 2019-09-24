class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.references :user, foreign_key: true
      t.references :routine, foreign_key: true
      t.date :start_time

      t.timestamps
    end
  end
end
