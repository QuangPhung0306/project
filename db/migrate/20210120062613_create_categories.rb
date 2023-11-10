class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :type_enum
      t.integer :order_enum
      t.string :slug

      t.timestamps
    end
    add_index :categories, :slug, unique: true
  end
end
