class CreatePersonalData < ActiveRecord::Migration[5.2]
  def change
    create_table :personal_data do |t|
      t.string :first_name
      t.string :last_name
      t.integer :room
      t.date :birth_date
      t.date :in_date
      t.date :out_plan_date
      t.date :out_actual_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
