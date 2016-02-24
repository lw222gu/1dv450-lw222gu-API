class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false
      t.timestamps null: false
    end
  end
end
