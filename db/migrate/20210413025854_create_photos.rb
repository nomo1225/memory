class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :image
      t.references :memory, foreign_key: true

      t.timestamps
    end
  end
end
