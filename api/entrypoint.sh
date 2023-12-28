# Exit immediately on any non-zero exit status
set -e

# Optimize config loading
php artisan config:cache

# Optimizing route loading
php artisan route:cache

# Optimizing view loading
php artisan view:cache

# Optimizing event loading
php artisan event:cache

# Optimize framework loading
php artisan optimize

# Run database migrations
php artisan migrate --force

# Execute arguments as command
exec "$@"
