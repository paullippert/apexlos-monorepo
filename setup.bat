@echo off

:: Navigate to each app and install dependencies separately
for /d %%i in (apps\*) do (
  echo Installing dependencies for %%i...
  cd %%i
  call npm install
  cd ..\..
)

:: Install root dependencies
call npm install --no-workspaces