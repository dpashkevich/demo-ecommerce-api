class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :shop_items, through: :order_items

  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank

  validates :customer, presence: true
  validate :must_have_at_least_one_item

  private

  def must_have_at_least_one_item
    errors.add(:base, "Order must have at least one item") if order_items.empty?
  end
end
