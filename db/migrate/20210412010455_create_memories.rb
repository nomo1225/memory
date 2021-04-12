class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
      t.string :title
      t.date :date
      t.string :content

      t.timestamps
    end
  end
end
