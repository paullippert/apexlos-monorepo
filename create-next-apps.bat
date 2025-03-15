@echo off
setlocal enabledelayedexpansion

:: Ensure the apps directory exists
if not exist apps mkdir apps

:: Create temporary directory for app creation
if not exist temp mkdir temp

:: Define app names and ports
set "apps[0]=borrower-portal"
set "ports[0]=3000"
set "apps[1]=loan-officer-portal"
set "ports[1]=3001"
set "apps[2]=operations-portal"
set "ports[2]=3002"

:: Create each Next.js app
for /L %%i in (0,1,2) do (
  set "app_name=!apps[%%i]!"
  set "port=!ports[%%i]!"
  
  :: Check if app already exists
  if exist "apps\!app_name!" (
    echo !app_name! already exists, updating port configuration...
    :: Update the port in the existing app
    powershell -Command "(Get-Content 'apps\!app_name!\package.json') -replace '\"dev\": \"next dev.*\"', '\"dev\": \"next dev --port !port!\"' | Set-Content 'apps\!app_name!\package.json'"
  ) else (
    echo Creating !app_name!...
    
    :: Create app in temp directory to avoid workspace protocol issues
    cd temp
    call npx create-next-app@latest !app_name! --ts --eslint --tailwind --app --src-dir --import-alias="@/*" --no-git
    cd ..
    
    :: Update package.json to add port configuration
    powershell -Command "(Get-Content 'temp\!app_name!\package.json') -replace '\"dev\": \"next dev\"', '\"dev\": \"next dev --port !port!\"' | Set-Content 'temp\!app_name!\package.json'"
    
    :: Move to apps directory
    if exist "temp\!app_name!" (
      move "temp\!app_name!" "apps\"
      echo !app_name! created and moved to apps directory
    ) else (
      echo Failed to create !app_name!
    )
  )
)

:: Clean up temp directory
rmdir /s /q temp

:: Update root package.json to include workspaces if they don't exist
powershell -Command "$json = Get-Content -Raw -Path package.json | ConvertFrom-Json; if (-not $json.workspaces) { $json | Add-Member -NotePropertyName 'workspaces' -NotePropertyValue @('apps/*', 'packages/*') -Force; $json | ConvertTo-Json -Depth 10 | Set-Content package.json }"

echo All applications set up successfully!
echo Run 'npm install' to install dependencies
echo Then 'npm run dev' to start development servers

endlocal