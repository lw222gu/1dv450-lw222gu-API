class CreateResourceOwners < ActiveRecord::Migration
  def change
    create_table :resource_owners do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.timestamps null: false
    end
  end
end
