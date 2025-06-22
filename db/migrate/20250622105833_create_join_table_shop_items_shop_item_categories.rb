class CreateJoinTableShopItemsShopItemCategories < ActiveRecord::Migration[8.0]
  def change
    create_join_table :shop_items, :shop_item_categories do |t|
      # t.index [:shop_item_id, :shop_item_category_id]
      # t.index [:shop_item_category_id, :shop_item_id]
    end
  end
end
