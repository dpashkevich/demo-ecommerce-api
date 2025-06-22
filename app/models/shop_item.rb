class ShopItem < ApplicationRecord
  has_and_belongs_to_many :shop_item_categories
  has_many :order_items, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
