class CreateShopItemCategoriesShopItems < ActiveRecord::Migration[8.0]
  def change
    create_table :shop_item_categories_shop_items, id: false do |t|
      t.references :shop_item, null: false, foreign_key: true
      t.references :shop_item_category, null: false, foreign_key: true
    end

    add_index :shop_item_categories_shop_items, [ :shop_item_id, :shop_item_category_id ], unique: true, name: 'index_shop_item_category_shop_item'
  end
end
