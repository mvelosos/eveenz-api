class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :account, foreign_key: true
      t.string :name
      t.text :description
      t.boolean :active, default: true
      t.string :kind
      t.date :date
      t.time :time
      t.text :tags, array: true, :default => []

      t.timestamps
    end
  end
end