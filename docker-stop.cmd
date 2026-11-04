@echo off
setlocal DisableDelayedExpansion
if not "%~1"=="" (
  echo Usage: docker-stop.cmd ^(no arguments^)
  exit /b 1
)
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js is required. Use the repository's pinned Node version.
  exit /b 1
)
node "%~dp0scripts\docker-local.mjs" stop
exit /b %errorlevel%
