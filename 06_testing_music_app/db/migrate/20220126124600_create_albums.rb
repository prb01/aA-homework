class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :studio, null: false, default: true
      t.bigint :artist_id, null: false
    end

    add_index :albums, :title
  end
end
