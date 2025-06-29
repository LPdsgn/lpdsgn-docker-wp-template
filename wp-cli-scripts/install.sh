#!/bin/bash
# This script runs after WordPress is installed

echo "Running post-installation tasks..."

# Set timezone
wp option update timezone_string 'Europe/Rome' --allow-root

# Set permalink structure
wp rewrite structure '/%postname%/' --allow-root

# Delete default content
wp post delete 1 2 --force --allow-root  # Delete "Hello World" post and sample page

# Install and activate plugins (examples)
# wp plugin install wordpress-seo --activate --allow-root
# wp plugin install contact-form-7 --activate --allow-root

# Create custom pages
wp post create --post_type=page --post_title='Home' --post_status=publish --allow-root

# Set front page
HOME_ID=$(wp post list --post_type=page --post_status=publish --fields=ID,post_title --format=csv --allow-root | grep "Home" | cut -d',' -f1)
wp option update show_on_front 'page' --allow-root
wp option update page_on_front $HOME_ID --allow-root

echo "Post-installation tasks completed!"