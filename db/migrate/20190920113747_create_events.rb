class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.date :start_date
      t.date :end_date
      t.boolean :closed, default: false, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
