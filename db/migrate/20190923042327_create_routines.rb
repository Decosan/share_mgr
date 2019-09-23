class CreateRoutines < ActiveRecord::Migration[5.2]
  def change
    create_table :routines do |t|
      t.string :title
      t.string :content
      t.integer :condition, default: 0, null: false

      t.timestamps
    end
  end
end
