class CreateShopItemCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :shop_item_categories do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
