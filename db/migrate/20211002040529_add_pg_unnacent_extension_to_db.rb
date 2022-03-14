class AddPgUnnacentExtensionToDb < ActiveRecord::Migration[6.1]
  def change
    execute "create extension unaccent;"
  end
end
