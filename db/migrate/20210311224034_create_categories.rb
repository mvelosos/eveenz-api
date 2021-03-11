class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    add_column :categories, :discarded_at, :datetime
    add_index :categories, :discarded_at
  end
end
