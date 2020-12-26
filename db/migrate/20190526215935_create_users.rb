class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'

    create_table :users do |t|
      t.uuid :uuid, null: false, unique: true, default: 'uuid_generate_v4()'
      t.string :email
      t.string :password_digest
      t.string :uid
      t.string :provider, default: 'api'
      t.boolean :active, default: true
      t.boolean :verified, default: true

      t.timestamps
    end
    add_column :users, :discarded_at, :datetime
    add_index :users, :discarded_at
  end
end
