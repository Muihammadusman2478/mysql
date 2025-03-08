#!/bin/bash

# Ask the user for the domain to search for
echo "Enter the domain to search for (e.g., cloudways.com):"
read search_domain

# Ask the user for the domain to replace with
echo "Enter the domain to replace with (e.g., wordpress-1192342-4200180.cloudwaysapps.com):"
read replace_domain

echo "Running search-replace commands..."

# Command 1: Replace http:// with https://
wp --skip-plugins --skip-themes search-replace 'http://' 'https://' --all-tables --report-changed-only --precise --allow-root

# Command 2: Replace the full domain (e.g., https://cloudways.com)
wp --skip-plugins --skip-themes search-replace "https://$search_domain" "https://$replace_domain" --all-tables --report-changed-only --precise --allow-root

# Command 3: Replace the domain (excluding email addresses)
wp --skip-plugins --skip-themes search-replace "/(?<!@)$search_domain/" "$replace_domain" --regex --all-tables --report-changed-only --precise --allow-root

echo "All search-replace commands completed!"

# Flush the cache
echo "Flushing cache..."
wp --skip-plugins --skip-themes cache flush --allow-root
echo "Cache flushed successfully!"
