#!/bin/bash

# Ensure the apps directory exists
mkdir -p apps

# Create temporary directory for app creation
mkdir -p temp

# Define app names and ports
declare -A app_ports=(
  ["borrower-portal"]=3000
  ["loan-officer-portal"]=3001
  ["operations-portal"]=3002
)

# Create each Next.js app
for app_name in "${!app_ports[@]}"; do
  port=${app_ports[$app_name]}
  
  # Check if app already exists
  if [ -d "apps/$app_name" ]; then
    echo "$app_name already exists, updating port configuration..."
    # Update the port in the existing app
    sed -i "s/\"dev\": \"next dev.*\"/\"dev\": \"next dev --port $port\"/" "apps/$app_name/package.json"
  else
    echo "Creating $app_name..."
    
    # Create app in temp directory to avoid workspace protocol issues
    cd temp
    npx create-next-app@latest $app_name --ts --eslint --tailwind --app --src-dir --import-alias="@/*" --no-git
    cd ..
    
    # Move app to apps directory
    if [ -d "temp/$app_name" ]; then
      # Update package.json to add port configuration
      sed -i "s/\"dev\": \"next dev\"/\"dev\": \"next dev --port $port\"/" "temp/$app_name/package.json"
      
      # Move to apps directory
      mv "temp/$app_name" "apps/"
      echo "$app_name created and moved to apps directory"
    else
      echo "Failed to create $app_name"
    fi
  fi
done

# Clean up temp directory
rm -rf temp

# Update root package.json to include workspaces
node -e "
const fs = require('fs');
const packageJson = JSON.parse(fs.readFileSync('./package.json', 'utf8'));
if (!packageJson.workspaces) {
  packageJson.workspaces = ['apps/*', 'packages/*'];
  fs.writeFileSync('./package.json', JSON.stringify(packageJson, null, 2));
}
"

echo "All applications set up successfully!"
echo "Run 'npm install' to install dependencies"
echo "Then 'npm run dev' to start development servers"