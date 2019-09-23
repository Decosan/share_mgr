class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.references :user, foreign_key: true
      t.references :routine, foreign_key: true
      t.date :day_until

      t.timestamps
    end
  end
end
