class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :shop_item

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :order, presence: true
  validates :shop_item, presence: true
end
