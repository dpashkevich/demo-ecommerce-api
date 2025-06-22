class ShopItemCategory < ApplicationRecord
  has_and_belongs_to_many :shop_items

  validates :title, presence: true
  validates :description, presence: true
end
