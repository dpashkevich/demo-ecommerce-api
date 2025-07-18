class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.references :shop_item, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
