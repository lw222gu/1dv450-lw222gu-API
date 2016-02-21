class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :password_digest, :null => false
      t.belongs_to :role
      t.timestamps null: false
    end
  end
end
