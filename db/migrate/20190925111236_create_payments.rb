class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.date :payed_date
      t.references :user, foreign_key: true
      t.integer :amount, default: 0, null: false
      t.integer :confirm, default: 0, null: false
      t.integer :method, default: 0, null: false
      
      t.timestamps
    end
  end
end
