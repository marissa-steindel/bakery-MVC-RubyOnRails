class Product < ApplicationRecord
  # associations
  has_many :product_categories
  has_many :categories, through: :product_categories

  # has_many :order_products
  # has_many :orders, through: :order_products

  # validations
  validates :name, presence: true

  # active storage
  has_one_attached :image
end
