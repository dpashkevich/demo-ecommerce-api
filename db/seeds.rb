# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creating seed data..."

# Create customers
customers = [
  { name: "John", surname: "Doe", email: "john.doe@example.com" },
  { name: "Jane", surname: "Smith", email: "jane.smith@example.com" },
  { name: "Bob", surname: "Johnson", email: "bob.johnson@example.com" },
  { name: "Alice", surname: "Brown", email: "alice.brown@example.com" },
  { name: "Charlie", surname: "Wilson", email: "charlie.wilson@example.com" }
]

customers.each do |customer_attrs|
  Customer.find_or_create_by!(email: customer_attrs[:email]) do |customer|
    customer.name = customer_attrs[:name]
    customer.surname = customer_attrs[:surname]
  end
end

puts "Created #{Customer.count} customers"

# Create shop item categories
categories = [
  { title: "Electronics", description: "Electronic devices and gadgets" },
  { title: "Clothing", description: "Fashion and apparel items" },
  { title: "Books", description: "Books and literature" },
  { title: "Home & Garden", description: "Home improvement and garden supplies" },
  { title: "Sports", description: "Sports equipment and accessories" }
]

categories.each do |category_attrs|
  ShopItemCategory.find_or_create_by!(title: category_attrs[:title]) do |category|
    category.description = category_attrs[:description]
  end
end

puts "Created #{ShopItemCategory.count} categories"

# Create shop items
shop_items = [
  { title: "iPhone 15 Pro", description: "Latest Apple smartphone with advanced features", price: 999.99, category_titles: [ "Electronics" ] },
  { title: "MacBook Air M2", description: "Lightweight laptop with powerful M2 chip", price: 1199.99, category_titles: [ "Electronics" ] },
  { title: "Nike Running Shoes", description: "Comfortable running shoes for athletes", price: 89.99, category_titles: [ "Clothing", "Sports" ] },
  { title: "The Great Gatsby", description: "Classic American novel by F. Scott Fitzgerald", price: 12.99, category_titles: [ "Books" ] },
  { title: "Garden Hose", description: "50ft durable garden hose for watering plants", price: 29.99, category_titles: [ "Home & Garden" ] },
  { title: "Yoga Mat", description: "Non-slip yoga mat for home workouts", price: 24.99, category_titles: [ "Sports" ] },
  { title: "Wireless Headphones", description: "Bluetooth headphones with noise cancellation", price: 199.99, category_titles: [ "Electronics" ] },
  { title: "Denim Jacket", description: "Classic denim jacket for casual wear", price: 59.99, category_titles: [ "Clothing" ] },
  { title: "Coffee Maker", description: "Automatic coffee maker for home use", price: 79.99, category_titles: [ "Home & Garden" ] },
  { title: "Basketball", description: "Official size basketball for indoor/outdoor use", price: 34.99, category_titles: [ "Sports" ] }
]

shop_items.each do |item_attrs|
  shop_item = ShopItem.find_or_create_by!(title: item_attrs[:title]) do |item|
    item.description = item_attrs[:description]
    item.price = item_attrs[:price]
  end

  # Add categories
  item_attrs[:category_titles].each do |category_title|
    category = ShopItemCategory.find_by(title: category_title)
    shop_item.shop_item_categories << category unless shop_item.shop_item_categories.include?(category)
  end
end

puts "Created #{ShopItem.count} shop items"

# Create sample orders
orders_data = [
  {
    customer_email: "john.doe@example.com",
    items: [
      { shop_item_title: "iPhone 15 Pro", quantity: 1 },
      { shop_item_title: "Wireless Headphones", quantity: 1 }
    ]
  },
  {
    customer_email: "jane.smith@example.com",
    items: [
      { shop_item_title: "Nike Running Shoes", quantity: 2 },
      { shop_item_title: "Yoga Mat", quantity: 1 }
    ]
  },
  {
    customer_email: "bob.johnson@example.com",
    items: [
      { shop_item_title: "The Great Gatsby", quantity: 1 },
      { shop_item_title: "Denim Jacket", quantity: 1 },
      { shop_item_title: "Coffee Maker", quantity: 1 }
    ]
  }
]

orders_data.each do |order_data|
  customer = Customer.find_by(email: order_data[:customer_email])
  next unless customer

  order = Order.create!(customer: customer)

  order_data[:items].each do |item_data|
    shop_item = ShopItem.find_by(title: item_data[:shop_item_title])
    next unless shop_item

    OrderItem.create!(
      order: order,
      shop_item: shop_item,
      quantity: item_data[:quantity]
    )
  end
end

puts "Created #{Order.count} orders with #{OrderItem.count} order items"
puts "Seed data creation completed!"
