class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.text :address, null: false

      t.timestamps
    end
  end
end
