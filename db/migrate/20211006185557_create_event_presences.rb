class CreateEventPresences < ActiveRecord::Migration[6.1]
  def change
    create_table :event_presences do |t|
      t.uuid :uuid, null: false, unique: true, default: 'uuid_generate_v4()'
      t.references :event, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
