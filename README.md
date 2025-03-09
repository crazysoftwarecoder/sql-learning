# Employee Database Setup

## Prerequisites
- Docker and Docker Compose installed on your system

## Getting Started

1. Clone this repository
2. Navigate to the project directory
3. Start the PostgreSQL database by running:
   ```bash
   docker-compose up -d
   ```
4. The database will be accessible at:
   - Host: localhost
   - Port: 5432
   - Database: employee_db
   - Username: postgres
   - Password: postgres

5. To stop the database:
   ```bash
   docker-compose down
   ```

The database will be automatically initialized with the employee table structure defined in `DDL.sql`.

## Health Check
The database container includes a health check that runs every 10 seconds to ensure the database is running properly. You can check the container status using:

## Available Make Commands

The following commands are available through the Makefile to help manage the database:

| Command | Description |
|---------|-------------|
| `make up` | Start the PostgreSQL container and wait for it to be ready |
| `make down` | Stop the PostgreSQL container |
| `make psql` | Connect to the PostgreSQL client inside the container |
| `make create-table` | Create the company and employee tables in the database |
| `make insert-data` | Insert sample employee and company records into the database |
| `make init` | Start the database and initialize it with schema and data |
| `make reset` | Reset the database (stops container, starts fresh, inserts data) |
| `make status` | Show the current status of the database container |
| `make help` | Display help information about available commands |

You can run any of these commands from the project directory. For example:
```bash
make init    # Initialize the database with sample data
make status  # Check the database status
```
