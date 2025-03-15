#!/bin/bash

# Navigate to each app and install dependencies separately
for app_dir in apps/*/; do
  if [ -d "$app_dir" ]; then
    echo "Installing dependencies for $app_dir..."
    cd "$app_dir"
    npm install
    cd ../../
  fi
done

# Install root dependencies
npm install --no-workspaces