# Exit immediately on any following non-zero exit status
set -e

# Run database migrations
php artisan migrate --force

# Execute arguments as command
exec "$@"
