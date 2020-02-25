class CreateWordbooks < ActiveRecord::Migration[5.2]
  def change
    create_table :wordbooks do |t|
      t.integer :user_id
      t.string :word
      t.text :meaning
      t.text :origin
      t.integer :image_id
      t.string :my_image_id

      t.timestamps
    end
    add_index :wordbooks, :word
  end
end
