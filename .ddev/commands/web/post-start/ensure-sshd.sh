#!/bin/bash

echo "Ensuring SSHD is running for Wetty..."

# Check if SSH keys exist, if not generate them
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
  echo "Generating SSH host keys..."
  sudo ssh-keygen -A
fi

# Now start sshd if not running
if ! pgrep -x "sshd" > /dev/null; then
  echo "Starting SSHD with sudo..."
  sudo /usr/sbin/sshd
fi