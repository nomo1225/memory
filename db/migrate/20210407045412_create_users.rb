class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name1
      t.string :name2
      t.string :email
      t.string :status
      t.string :password_digest
      t.string :image
      t.string :reset_token

      t.timestamps
    end
  end
end
