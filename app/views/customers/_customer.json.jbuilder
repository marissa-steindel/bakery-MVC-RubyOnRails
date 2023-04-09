json.extract! customer, :id, :name, :username, :password_digest, :address, :province_id, :created_at, :updated_at
json.url customer_url(customer, format: :json)
