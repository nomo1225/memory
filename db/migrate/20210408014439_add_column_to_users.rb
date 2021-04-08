class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :anniversary_day, :date
    add_column :users, :memories_place, :string
  end
end
