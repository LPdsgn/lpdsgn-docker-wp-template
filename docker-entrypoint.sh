#!/bin/bash
set -euo pipefail

# Wait for database to be ready
echo "Waiting for database..."
while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
    sleep 1
done

# Call the original WordPress entrypoint
docker-entrypoint.sh "$@" &

# Wait for Apache to start
sleep 10

# Check if WordPress is already installed
if ! wp core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    
    # Download WordPress if wp-config.php doesn't exist
    if [ ! -f wp-config.php ]; then
        wp config create \
            --dbname="$WORDPRESS_DB_NAME" \
            --dbuser="$WORDPRESS_DB_USER" \
            --dbpass="$WORDPRESS_DB_PASSWORD" \
            --dbhost="$WORDPRESS_DB_HOST" \
            --dbprefix="${WORDPRESS_TABLE_PREFIX}" \
            --allow-root
    fi
    
    # Install WordPress
    wp core install \
        --url="http://localhost:8000" \
        --title="${WORDPRESS_BLOG_NAME}" \
        --admin_user="${WORDPRESS_ADMIN_USERNAME}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root
    
    echo "WordPress installation complete!"
    
    # Run any custom WP-CLI scripts
    if [ -f /var/www/html/wp-cli-scripts/install.sh ]; then
        echo "Running custom installation scripts..."
        bash /var/www/html/wp-cli-scripts/install.sh
    fi
else
    echo "WordPress is already installed."
    
    # Run any custom WP-CLI scripts for updates
    if [ -f /var/www/html/wp-cli-scripts/update.sh ]; then
        echo "Running update scripts..."
        bash /var/www/html/wp-cli-scripts/update.sh
    fi
fi

# Keep the container running
wait