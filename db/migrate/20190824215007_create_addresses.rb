class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.string :street
      t.string :number
      t.string :complement
      t.string :neighborhood
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
    add_column :addresses, :discarded_at, :datetime
    add_index :addresses, :discarded_at
  end
end
