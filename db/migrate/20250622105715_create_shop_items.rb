class CreateShopItems < ActiveRecord::Migration[8.0]
  def change
    create_table :shop_items do |t|
      t.string :title
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
