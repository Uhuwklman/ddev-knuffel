#!/bin/bash
set -e

cd /var/www/html/local_kniffel
source /var/www/venv/bin/activate

echo "Running flask db upgrade for MariaDB..."
flask db upgrade