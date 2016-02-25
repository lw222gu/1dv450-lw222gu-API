class CreateResourceOwners < ActiveRecord::Migration
  def change
    create_table :resource_owners do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.timestamps null: false
      t.belongs_to :resource_owner
    end
  end
end
