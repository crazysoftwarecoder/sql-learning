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
