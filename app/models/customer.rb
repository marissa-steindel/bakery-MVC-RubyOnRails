class Customer < ApplicationRecord
  # associations
  has_many :orders
  has_many :products, through: :orders
  belongs_to :province

  # validations
  validates :name, presence: true
  # validates :username, presence: true
  # validates :address, presence: true
  validates :province, presence: true

  # virtual attributes of the Customer model supplied by bcrypt
  # password:string
  # password_confirmation:string
  has_secure_password

end
