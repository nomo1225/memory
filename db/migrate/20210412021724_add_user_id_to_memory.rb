class AddUserIdToMemory < ActiveRecord::Migration[5.2]
  def change
    add_column :memories, :user_id, :string
  end
end
