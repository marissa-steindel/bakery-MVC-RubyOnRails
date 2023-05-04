require "csv"

# Destroy all database content
# Province.destroy_all
# Customer.destroy_all
# Product.destroy_all
# Category.destroy_all
# AdminUser.destroy_all

# SEED SALES TAX
# # salestax_csv_file = Rails.root.join("db/salestax.csv")
# # salestax_csv_data = File.read(csv_file)
# # salestax_csv_data = CSV.parse(csv_data, headers: true)

salestax_csv_data =  CSV.parse(File.read(Rails.root.join("db/salestax.csv")), headers: true)

salestax_csv_data.each do |row|
  puts "#{row["province"]}, #{row["code"]}"
  puts "GST: #{row["GST"]}"
  puts "HST: #{row["PST"]}"
  puts "PST: #{row["HST"]}"
  puts
end

salestax_csv_data.each do |row|
  province = Province.create(
    name:   row["province"],
    code:   row["code"],
    PST:    row["PST"],
    GST:    row["GST"],
    HST:    row["HST"]
  )
end


# SEED customers
10.times do
  customer = Customer.create(
    name: Faker::Name.name,
    address: Faker::Address.street_address,
    username: Faker::Lorem.word,
    password_digest: Faker::Internet.password,
    province: Province.all.sample
  )
  puts "#{customer.name} from #{customer.province.name} created"
end

# SEED categories
categories = ["loaf", "sweet", "savoury", "pastry", "cookie", "bun", "flatbread"]

categories.each do |c|
  new_cat = Category.create(name: c)
  puts "#{c} created"
end

# SEED PRODUCTS
product_json_data = JSON.parse(File.read(Rails.root.join("db/products.json")))

product_json_data.each do |p|
  puts
  puts "Product: #{p["name"]}"
  puts "Price: #{p["price"]}"
  puts "Description: #{p["description"]}"
  puts "Categories: #{p["categories"]}"
  puts "Image: #{p["img"]}"
  puts

  new_prod = Product.create(
    name:         p["name"],
    price:        p["price"].to_i,
    description:  p["description"],
    # image:        p["img"]
  )
  new_prod.image.attach(
      io: File.open("app/assets/images/products/#{p["img"]}"),
      filename: p["img"]
    )
end



product_json_data.each do |p|
  p["categories"].each do |pc|
  new_prod_cat = ProductCategory.new(
    product_id: Product.find_by(name: p["name"]).id,
    category_id: Category.find_by(name: pc).id
  )
    unless new_prod_cat.save
      puts new_prod_cat.errors.full_messages
    end
    puts "ProductCategory: #{p["name"]} - #{pc}"
  end
end