class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.integer :wage, null: false
      t.string :title, null: false, limit: 250
      t.timestamps null: false
    end
  end
end
