class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.text :seo_description
      t.string :seo_keywords
      t.integer :order_enum
      t.string :slug
      t.references :category

      t.timestamps
    end
    add_index :posts, :slug, unique: true
  end
end
