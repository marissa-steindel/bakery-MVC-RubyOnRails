class Customer < ApplicationRecord
  has_many :orders
  has_many :products, through: :orders
  belongs_to :province
end
