class CreateLocalizations < ActiveRecord::Migration[5.2]
  def change
    create_table :localizations do |t|
      t.references :localizable, polymorphic: true
      t.decimal :latitude, :precision => 11, :scale => 8
      t.decimal :longitude, :precision => 11, :scale => 8

      t.timestamps
    end
  end
end
