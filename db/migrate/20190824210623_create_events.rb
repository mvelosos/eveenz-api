class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.uuid :uuid, null: false, unique: true, default: 'uuid_generate_v4()'
      t.references :account, foreign_key: true
      t.string :name
      t.text :description
      t.boolean :active, default: true
      t.string :privacy
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.boolean :undefined_end, default: false
      t.text :tags, array: true, :default => []

      t.timestamps
    end
    add_column :events, :discarded_at, :datetime
    add_index :events, :discarded_at
  end
end
