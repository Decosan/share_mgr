class CreateEventLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :event_labels do |t|
      t.references :event, foreign_key: true
      t.references :label, foreign_key: true

      t.timestamps
    end
  end
end
