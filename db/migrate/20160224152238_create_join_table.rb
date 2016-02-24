class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :salaries, :tags do |t|
      t.index [:salary_id, :tag_id]
      t.index [:tag_id, :salary_id]
    end
  end
end
