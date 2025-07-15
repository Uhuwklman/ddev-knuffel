#!/bin/bash
set -e

# Start sshd if not already running
if ! pgrep -x "sshd" > /dev/null; then
  echo "Starting SSHD from entrypoint script..."
  sudo /usr/sbin/sshd
fi

# Start gunicorn in background
echo "Starting Gunicorn Flask application..."
/var/www/venv/bin/gunicorn --bind 0.0.0.0:5000 --access-logfile - --error-logfile - knuffel:app &

# Use DDEV's normal startup script to handle nginx and other services
#echo "Starting DDEV services..."
#exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord-nginx-fpm.conf