# Database configuration
DB_NAME=employee_db
DB_USER=postgres
DB_PASSWORD=postgres
DB_CONTAINER=employee_db

# Default target
.PHONY: all
all: help

# Start the database
.PHONY: up
up:
	@echo "Starting PostgreSQL container..."
	docker-compose up -d
	@echo "Waiting for PostgreSQL to be ready..."
	@until docker exec $(DB_CONTAINER) pg_isready -U $(DB_USER); do \
		echo "Waiting for database to be ready..."; \
		sleep 2; \
	done
	@echo "PostgreSQL is up and running!"
# Connect to PostgreSQL client
.PHONY: psql
psql:
	@echo "Connecting to PostgreSQL client..."
	@docker exec -it $(DB_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME)
	@echo "Disconnected from PostgreSQL client."

# Stop the database
.PHONY: down
down:
	@echo "Stopping PostgreSQL container..."
	docker-compose down
	@echo "PostgreSQL container stopped."

# Create employee table
.PHONY: create-table
create-table:
	@echo "Creating company table..."
	cat create_company.sql | docker exec -i $(DB_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME)
	@echo "Company table created successfully!"
	@echo "Creating employee table..."
	cat create_employee_table.sql | docker exec -i $(DB_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME)
	@echo "Employee table created successfully!"

# Insert employee records
.PHONY: insert-data
insert-data:
	@echo "Inserting employee and company records..."
	cat inserts.sql | docker exec -i $(DB_CONTAINER) psql -U $(DB_USER) -d $(DB_NAME)
	@echo "Employee and company records inserted successfully!"

# Initialize database with schema and data
.PHONY: init
init: up insert-data
	@echo "Database initialized with schema and data!"

# Reset database (down and up)
.PHONY: reset
reset: down up insert-data
	@echo "Database has been reset with fresh data!"

# Show database status
.PHONY: status
status:
	@echo "Database container status:"
	@docker ps --filter "name=$(DB_CONTAINER)" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Display help information
.PHONY: help
help:
	@echo "Employee Database Management"
	@echo ""
	@echo "Usage:"
	@echo "  make up           - Start the PostgreSQL container"
	@echo "  make down         - Stop the PostgreSQL container"
	@echo "  make insert-data  - Insert employee records into the database"
	@echo "  make init         - Start the database and insert data"
	@echo "  make reset        - Reset the database (down, up, insert data)"
	@echo "  make status       - Show database container status"
	@echo "  make help         - Show this help message"