class CreateSearchCaches < ActiveRecord::Migration[5.2]
  def change
    create_table :search_caches do |t|
      t.string :word
      t.text :definition
      t.text :origin

      t.timestamps
    end
    add_index :search_caches, :word
  end
end
