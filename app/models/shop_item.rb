class ShopItem < ApplicationRecord
  has_and_belongs_to_many :shop_item_categories, join_table: "shop_item_categories_shop_items"
  has_many :order_items, dependent: :restrict_with_error

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
