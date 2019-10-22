class CreateCardPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :card_payments do |t|
      t.date :month, default: -> { "now()" }, null: false
      t.integer :amount, default: 0, null: false
      t.integer :confirm, default: 0, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
