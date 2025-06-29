# WordPress Docker Development Environment

A Docker-based WordPress development environment with WP-CLI, MariaDB, and phpMyAdmin.

## Features

- WordPress (latest) with PHP 8.2
- MariaDB 11.4 database
- phpMyAdmin for database management
- WP-CLI for automated setup
- Pre-configured PHP extensions (soap, curl, mbstring, gd, etc.)
- Custom installation scripts

## Prerequisites

- Docker Desktop (macOS/Windows) or Docker Engine (Linux)
- Git

## Quick Start

1. Clone the repository:
   ```bash
   git clone <your-repo-url>
   cd boosha-docker-wp-webtic
   ```

2. Copy the environment example file:
   ```bash
   cp .env.example .env
   ```

3. Edit `.env` with your preferred settings:
   ```bash
   # Edit with your favorite editor
   nano .env
   ```

4. Build and start the containers:
   ```bash
   docker compose build
   docker compose up -d
   ```

5. Access your sites:
   - WordPress: http://localhost:8000
   - phpMyAdmin: http://localhost:8080

## Environment Variables

See `.env.example` for all available variables. Key variables:

- `WORDPRESS_DB_NAME`: Database name
- `WORDPRESS_DB_USER`: Database username
- `WORDPRESS_DB_PASSWORD`: Database password
- `WORDPRESS_ADMIN_USERNAME`: WordPress admin username
- `WORDPRESS_ADMIN_PASSWORD`: WordPress admin password
- `WORDPRESS_ADMIN_EMAIL`: WordPress admin email

## WP-CLI Scripts

Custom scripts in `wp-cli-scripts/`:
- `install.sh`: Runs after first installation
- `update.sh`: Runs on container restart

Edit these files to customize your WordPress setup.

## Common Commands

```bash
# Start containers
docker compose up -d

# Stop containers
docker compose down

# View logs
docker compose logs -f wordpress

# Run WP-CLI commands
docker compose exec wordpress wp --allow-root <command>

# Rebuild after changes
docker compose build --no-cache
```

## Development Workflow

1. Your WordPress files are in the current directory
2. Changes are automatically synced to the container
3. Database data persists in Docker volumes
4. Use Git to track only your custom themes/plugins

## Security Notes

- Never commit `.env` files with real passwords
- Use strong passwords in production
- Keep your Docker images updated