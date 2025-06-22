# E-Commerce API demo (Ruby on Rails)

This is a demo project created to compare the development experience of using various different editors/IDEs with AI features.

---

## Getting Started

This is a Ruby on Rails API-only backend application using PostgreSQL for development and test environments.

### Prerequisites

- Ruby 3.2.7
- Rails 8.x
- PostgreSQL 14+
- Bundler

### Setup Instructions

1. **Install dependencies:**

   ```sh
   bundle install
   ```

2. **Configure your database:**
   Edit `config/database.yml` if needed (default is local Postgres, user: <your local user>).

3. **Create and setup databases:**

   ```sh
   bin/rails db:create db:migrate db:seed
   ```

   This will set up both development and test databases.

4. **Run the test suite:**

   ```sh
   bin/rails test
   ```

5. **Start the Rails server:**
   ```sh
   bin/rails server
   ```

---

## Additional Information

- **System dependencies:** See the Gemfile for required gems.
- **Services:**
  - Job queues: Solid Queue (see config/queue.yml)
  - Cache: Solid Cache (see config/cache.yml)
- **Deployment:**
  - See Dockerfile and config/deploy.yml for deployment options.

---

For more details, see the official [Ruby on Rails Guides](https://guides.rubyonrails.org/).
