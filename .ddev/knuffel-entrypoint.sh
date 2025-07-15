#!/bin/bash
set -e

# Ensure /app and app.db are owned by www-data
chown -R www-data:www-data /app
chmod -R 775 /app
if [ -f /app/app.db ]; then
  chown www-data:www-data /app/app.db
  chmod 664 /app/app.db
fi

# Debug SSH configuration
echo "SSH server configuration:"
cat /etc/ssh/sshd_config | grep -v "^#" | grep -v "^$"

# Start SSH server in the background
mkdir -p /var/run/sshd
echo "Starting SSH server..."
/usr/sbin/sshd -D -e &

# Create or update .env file with consistent database settings
echo "DATABASE_URL=mariadb+pymysql://db:db@db:3306/db" > /app/.env
echo "SECRET_KEY=${SECRET_KEY:-some_default_secret_key}" >> /app/.env
echo "FLASK_APP=knuffel.py" >> /app/.env
chown www-data:www-data /app/.env

# Update the restricted shell to include environment variables
cat > /usr/local/bin/knuffel-shell << 'EOF'
#!/bin/bash
if [ -f /main.py ]; then
  cd /
  export DATABASE_URL="mariadb+pymysql://db:db@db:3306/db"
  exec python main.py
elif [ -f /app/main.py ]; then
  cd /app
  export DATABASE_URL="mariadb+pymysql://db:db@db:3306/db"
  exec python main.py
else
  echo "main.py not found"; exit 1
fi
EOF

chmod +x /usr/local/bin/knuffel-shell

# Run DB migrations (retry until success)
while true; do
    flask db upgrade && break
    echo "Upgrade command failed, retrying in 5 secs..."
    sleep 5
done

# Start the Flask app with gunicorn in the foreground
echo "Starting Flask application with gunicorn..."
exec gunicorn -b :5000 --access-logfile - --error-logfile - knuffel:app