# E-Commerce API Demo (Ruby on Rails)

This is a demo project created to compare the development experience of using various different editors/IDEs with AI features.

This project implements RESTful API built with Ruby on Rails designed for e-commerce applications. The API uses PostgreSQL for database storage and follows REST principles for resource management.

## System Requirements

* Ruby 3.2.8 or higher
* bin/rails 8.0.2 or higher
* PostgreSQL 12 or higher

## Getting Started

### Setup and Installation

1. Clone the repository:
   ```
   git clone [repository URL]
   cd [repository name]
   ```

2. Install dependencies:
   ```
   bundle install
   ```

3. Database setup:
   
   Ensure PostgreSQL is running on your system. Then create and set up the database:
   ```
   bin/rails db:create
   bin/rails db:migrate
   ```

4. Running the server:
   ```
   bin/rails server
   ```
   The API will be available at `http://localhost:3000`.

### Running Tests

Run the test suite to ensure everything is working correctly:
```
bin/rails test
```

## API Endpoints

Below are examples of how to interact with the API endpoints using `curl`:

### Health Check
```
curl -X GET http://localhost:3000/rails/info/routes
```

## Development

### Available Tasks

- Run the bin/rails console: `bin/rails console`
- Run database migrations: `bin/rails db:migrate`
- Check API routes: `bin/rails routes`

## Deployment

This application includes Docker configuration for easy deployment. See the `Dockerfile` and related configuration for details.

### Using Kamal for Deployment

This project is configured to use Kamal for container-based deployments:

```
bundle exec kamal setup
bundle exec kamal deploy
```

## Troubleshooting

If you encounter database connection issues, ensure that:
1. PostgreSQL is installed and running
2. Database configuration in `config/database.yml` matches your PostgreSQL setup
3. The database user has appropriate permissions