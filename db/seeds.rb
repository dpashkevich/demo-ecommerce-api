# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data to ensure idempotency
puts "Clearing existing data..."
# Destroy records in order to maintain referential integrity
OrderItem.destroy_all
Order.destroy_all
# Manually clear the join table to avoid foreign key constraints
ActiveRecord::Base.connection.execute("TRUNCATE shop_item_categories_shop_items RESTART IDENTITY CASCADE") rescue puts "Join table already empty"
ShopItem.destroy_all
ShopItemCategory.destroy_all
Customer.destroy_all

# Create customers
puts "Creating customers..."
customer = Customer.create!(
  name: "John",
  surname: "Doe",
  email: "john.doe@example.com"
)

# Create shop item categories
puts "Creating shop item categories..."
electronics = ShopItemCategory.create!(
  title: "Electronics",
  description: "Electronic devices and accessories"
)

clothing = ShopItemCategory.create!(
  title: "Clothing",
  description: "Apparel and fashion items"
)

# Create shop items
puts "Creating shop items..."
laptop = ShopItem.create!(
  title: "Laptop",
  description: "High-performance laptop with 16GB RAM",
  price: 1299.99,
  shop_item_categories: [ electronics ]
)

smartphone = ShopItem.create!(
  title: "Smartphone",
  description: "Latest model smartphone with 128GB storage",
  price: 899.99,
  shop_item_categories: [ electronics ]
)

tshirt = ShopItem.create!(
  title: "T-Shirt",
  description: "Cotton t-shirt in various colors",
  price: 24.99,
  shop_item_categories: [ clothing ]
)

# Create orders
puts "Creating orders..."
order = Order.new(customer: customer)
order.order_items.build(shop_item: laptop, quantity: 1)
order.order_items.build(shop_item: tshirt, quantity: 2)
order.save!

puts "Seeding completed successfully!"
