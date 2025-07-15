#!/bin/bash
set -e

# Start sshd if not already running
if ! pgrep -x "sshd" > /dev/null; then
  echo "Starting SSHD from entrypoint script..."
  sudo /usr/sbin/sshd
fi

# Start gunicorn in background
#echo "Starting Gunicorn Flask application..."
# Starting via docker image instead
#/var/www/venv/bin/gunicorn --bind 0.0.0.0:5000 --access-logfile - --error-logfile - knuffel:app &

# Use Docker image to launch Knuffel
#exec python main.py

# Let DDEV handle the rest
echo "Starting DDEV services..."
exec /pre-start.sh