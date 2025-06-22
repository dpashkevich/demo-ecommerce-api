# E-Commerce API demo (Ruby on Rails)

This is a demo project created to compare the development experience of
using various different editors/IDEs with AI features.

The project implements a complete RESTful API for an online shop built with Ruby on Rails. This application provides full CRUD operations for customers, shop item categories, shop items, and orders.

## Features

- **Customer Management**: Create, read, update, and delete customer information
- **Category Management**: Organize shop items into categories
- **Shop Item Management**: Manage products with pricing and category associations
- **Order Management**: Create and manage orders with multiple items
- **RESTful API**: Clean, consistent API endpoints following REST conventions
- **Comprehensive Testing**: Full test coverage for all endpoints
- **Data Validation**: Robust validation for all entities
- **JSON API**: All responses in JSON format

## Data Models

### Customer

- **ID** (integer, auto-generated)
- **Name** (string, required)
- **Surname** (string, required)
- **Email** (string, required, unique, email format)

### ShopItemCategory

- **ID** (integer, auto-generated)
- **Title** (string, required)
- **Description** (text, required)

### ShopItem

- **ID** (integer, auto-generated)
- **Title** (string, required)
- **Description** (text, required)
- **Price** (decimal, required, > 0)
- **Categories** (many-to-many relationship with ShopItemCategory)

### OrderItem

- **ID** (integer, auto-generated)
- **Order** (belongs to Order)
- **ShopItem** (belongs to ShopItem)
- **Quantity** (integer, required, > 0)

### Order

- **ID** (integer, auto-generated)
- **Customer** (belongs to Customer, required)
- **Items** (has many OrderItems through association)

## Prerequisites

- Ruby 3.2.7
- Rails 8.x
- PostgreSQL 14+
- Bundler

## Setup Instructions

### 1. Install Dependencies

```sh
bundle install
```

### 2. Configure Database

The application uses PostgreSQL. Edit `config/database.yml` if needed (default is local Postgres, user: your local user).

### 3. Create and Setup Databases

```sh
bin/rails db:create db:migrate db:seed
```

This will:

- Create development and test databases
- Run all migrations to set up the schema
- Seed the database with sample data

### 4. Run Tests

```sh
bin/rails test
```

### 5. Start the Rails Server

```sh
bin/rails server
```

The API will be available at `http://localhost:3000`

## API Endpoints

### Base URL

All API endpoints are prefixed with `/api/v1/`

### Customers

| Method    | Endpoint                | Description             |
| --------- | ----------------------- | ----------------------- |
| GET       | `/api/v1/customers`     | List all customers      |
| GET       | `/api/v1/customers/:id` | Get a specific customer |
| POST      | `/api/v1/customers`     | Create a new customer   |
| PATCH/PUT | `/api/v1/customers/:id` | Update a customer       |
| DELETE    | `/api/v1/customers/:id` | Delete a customer       |

### Shop Item Categories

| Method    | Endpoint                           | Description             |
| --------- | ---------------------------------- | ----------------------- |
| GET       | `/api/v1/shop_item_categories`     | List all categories     |
| GET       | `/api/v1/shop_item_categories/:id` | Get a specific category |
| POST      | `/api/v1/shop_item_categories`     | Create a new category   |
| PATCH/PUT | `/api/v1/shop_item_categories/:id` | Update a category       |
| DELETE    | `/api/v1/shop_item_categories/:id` | Delete a category       |

### Shop Items

| Method    | Endpoint                 | Description              |
| --------- | ------------------------ | ------------------------ |
| GET       | `/api/v1/shop_items`     | List all shop items      |
| GET       | `/api/v1/shop_items/:id` | Get a specific shop item |
| POST      | `/api/v1/shop_items`     | Create a new shop item   |
| PATCH/PUT | `/api/v1/shop_items/:id` | Update a shop item       |
| DELETE    | `/api/v1/shop_items/:id` | Delete a shop item       |

### Orders

| Method    | Endpoint             | Description          |
| --------- | -------------------- | -------------------- |
| GET       | `/api/v1/orders`     | List all orders      |
| GET       | `/api/v1/orders/:id` | Get a specific order |
| POST      | `/api/v1/orders`     | Create a new order   |
| PATCH/PUT | `/api/v1/orders/:id` | Update an order      |
| DELETE    | `/api/v1/orders/:id` | Delete an order      |

## API Usage Examples

### Create a Customer

```bash
curl -X POST http://localhost:3000/api/v1/customers \
  -H "Content-Type: application/json" \
  -d '{
    "customer": {
      "name": "John",
      "surname": "Doe",
      "email": "john.doe@example.com"
    }
  }'
```

### Create a Shop Item Category

```bash
curl -X POST http://localhost:3000/api/v1/shop_item_categories \
  -H "Content-Type: application/json" \
  -d '{
    "shop_item_category": {
      "title": "Electronics",
      "description": "Electronic devices and gadgets"
    }
  }'
```

### Create a Shop Item

```bash
curl -X POST http://localhost:3000/api/v1/shop_items \
  -H "Content-Type: application/json" \
  -d '{
    "shop_item": {
      "title": "iPhone 15 Pro",
      "description": "Latest Apple smartphone",
      "price": 999.99,
      "shop_item_category_ids": [1]
    }
  }'
```

### Create an Order

```bash
curl -X POST http://localhost:3000/api/v1/orders \
  -H "Content-Type: application/json" \
  -d '{
    "order": {
      "customer_id": 1,
      "order_items_attributes": [
        {
          "shop_item_id": 1,
          "quantity": 2
        },
        {
          "shop_item_id": 2,
          "quantity": 1
        }
      ]
    }
  }'
```

## Response Formats

### Success Responses

- **GET requests**: Return the requested data in JSON format
- **POST requests**: Return the created resource with status 201
- **PATCH/PUT requests**: Return the updated resource with status 200
- **DELETE requests**: Return status 204 (No Content)

### Error Responses

- **422 Unprocessable Entity**: Validation errors
- **404 Not Found**: Resource not found
- **400 Bad Request**: Invalid request format

Example error response:

```json
{
  "errors": ["Email has already been taken", "Name can't be blank"]
}
```

## Testing

### Run All Tests

```sh
bin/rails test
```

### Run Specific Test Files

```sh
bin/rails test test/controllers/api/v1/customers_controller_test.rb
bin/rails test test/controllers/api/v1/shop_item_categories_controller_test.rb
bin/rails test test/controllers/api/v1/shop_items_controller_test.rb
bin/rails test test/controllers/api/v1/orders_controller_test.rb
```

### Test Coverage

The test suite includes:

- CRUD operations for all entities
- Validation error handling
- 404 error handling for non-existent resources
- Nested attribute handling for orders

## Sample Data

The application comes with pre-seeded data including:

- 5 customers with different names and emails
- 5 shop item categories (Electronics, Clothing, Books, Home & Garden, Sports)
- 10 shop items across different categories
- 3 sample orders with multiple items

## Database Schema

The application uses PostgreSQL with the following key features:

- Foreign key constraints for data integrity
- Many-to-many relationship between ShopItems and ShopItemCategories
- Nested attributes for OrderItems within Orders
- Proper indexing for performance

## Development

### Adding New Features

1. Generate models: `bin/rails generate model ModelName`
2. Generate controllers: `bin/rails generate controller Api::V1::ModelNames`
3. Add routes to `config/routes.rb`
4. Implement CRUD operations in controllers
5. Add validations to models
6. Write tests
7. Update documentation

### Code Style

The project follows Ruby on Rails conventions and includes:

- RuboCop configuration for code style enforcement
- Consistent API response formats
- Proper error handling
- RESTful routing

## Deployment

The application includes:

- Dockerfile for containerized deployment
- Kamal deployment configuration
- Production-ready database configuration

For deployment instructions, see the Dockerfile and `config/deploy.yml`.

## License

This project is open source and available under the MIT License.
