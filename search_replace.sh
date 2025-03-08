#!/bin/bash

# Ask the user for the domain to search for
echo "Enter the domain to search for (e.g., cloudways.com):"
read search_domain

# Ask the user for the domain to replace with
echo "Enter the domain to replace with (e.g., wordpress-1192342-4200180.cloudwaysapps.com):"
read replace_domain

echo "Running search-replace commands..."

wp --skip-plugins --skip-themes search-replace "$search_domain" "$replace_domain"  --all-tables --report-changed-only --precise --allow-root

echo "All search-replace commands completed!"

# Flush the cache
echo "Flushing cache..."
wp --skip-plugins --skip-themes cache flush --allow-root
echo "Cache flushed successfully!"
