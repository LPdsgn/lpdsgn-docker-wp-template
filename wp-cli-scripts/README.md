# WP-CLI Scripts

This directory contains scripts that are automatically executed by WP-CLI during container startup.

## Scripts

### install.sh
- Runs only once after WordPress is first installed
- Use this for initial setup tasks like:
  - Installing plugins/themes
  - Creating default pages
  - Setting up options
  - Configuring permalinks

### update.sh
- Runs every time the container starts (if WordPress is already installed)
- Use this for maintenance tasks like:
  - Updating plugins/themes
  - Clearing caches
  - Running migrations

## Usage

1. Edit the scripts to add your custom WP-CLI commands
2. Rebuild and restart the container:
   ```bash
   docker compose down
   docker compose build
   docker compose up -d
   ```

## Common WP-CLI Commands

```bash
# Plugin management
wp plugin install <plugin-name> --activate --allow-root
wp plugin deactivate <plugin-name> --allow-root
wp plugin delete <plugin-name> --allow-root

# Theme management
wp theme install <theme-name> --activate --allow-root
wp theme activate <theme-name> --allow-root

# User management
wp user create <username> <email> --role=editor --allow-root

# Options
wp option update <option-name> <value> --allow-root

# Database
wp db export backup.sql --allow-root
wp db import backup.sql --allow-root
```

## Notes

- Always use `--allow-root` flag in Docker containers
- Scripts must be executable (chmod +x)
- Check container logs for script output: `docker compose logs wordpress`