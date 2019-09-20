class CreatePersonnels < ActiveRecord::Migration[5.2]
  def change
    create_table :personnels do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :room, default: 0, null: false
      t.integer :gender, default: 0, null: false
      t.date :birth_date, null: false
      t.date :in_date, null: false
      t.date :out_plan_date
      t.date :out_actual_date
      t.references :user, foreign_key: true
      # t.belongs_to :user

      t.timestamps
    end
  end
end
