class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :shop_items, through: :order_items

  accepts_nested_attributes_for :order_items

  validates :customer, presence: true
end
