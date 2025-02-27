class CreateCirculationRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :circulation_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :due_date
      t.datetime :returned_at

      t.timestamps
    end
  end
end
