class ShopItemCategory < ApplicationRecord
  has_and_belongs_to_many :shop_items, join_table: "shop_item_categories_shop_items"

  validates :title, presence: true
end
