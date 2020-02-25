class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.integer :search_cache_id
      t.string :word_image

      t.timestamps
    end
  end
end
