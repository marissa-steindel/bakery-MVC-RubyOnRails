require "csv"

# Destroy all database content
# Customer.destroy_all
# Province.destroy_all
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


# salestax_csv_data.each do |row|
#   province = Province.create(  name:   row["province"],
#                                 code:   row["code"],
#                                 PST:    row["PST"],
#                                 GST:    row["GST"],
#                                 HST:    row["HST"]
#                             )
# end

# Province.all.each do |prov|
#   puts "Name: #{prov.name}"
#   puts "Code: #{prov.code}"
#   puts "GST: #{prov.GST}"
#   puts "HST: #{prov.HST}"
#   puts "PST: #{prov.PST}"
#   puts
# end

# salestax_csv_data.each do |row|
#   province = Province.create(
#     name:   row["province"],
#     code:   row["code"],
#     PST:    row["PST"],
#     GST:    row["GST"],
#     HST:    row["HST"]
#   )



# # SEED customers
# 30.times do
#   customer = Customer.create(
#     name: Faker::Name.name,
#     address: Faker::Address.street_address,
#     username: Faker::Lorem.word,
#     password_digest: Faker::Internet.password,
#     province: Province.find(rand(1..13))
#   )
#   puts "#{customer.name} from #{customer.province.name} created"
# end

# SEED categories
categories = ["loaf", "sweet", "savoury", "pastry", "cookie", "cake", "muffin", "bun", "flatbread"]

categories.each do |c|
  new_cat = Category.create(name: c)
end