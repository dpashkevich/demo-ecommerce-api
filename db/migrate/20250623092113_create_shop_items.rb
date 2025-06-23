class CreateShopItems < ActiveRecord::Migration[8.0]
  def change
    create_table :shop_items do |t|
      t.string :title, null: false
      t.string :description
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
