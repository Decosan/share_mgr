class CreateAssignReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :assign_reviews do |t|
      t.references :assignment, foreign_key: true
      t.references :review, foreign_key: true

      t.timestamps
    end
  end
end
