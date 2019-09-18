class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.date :birth_date
      t.text :image

      t.timestamps
    end
  end
end
