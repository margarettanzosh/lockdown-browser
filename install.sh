#!/bin/bash
set -e

DMG_URL="https://github.com/margarettanzosh/lockdown-browser/releases/download/v1.0.0/Lockdown%20Browser-1.0.0-arm64.dmg"
DMG_PATH="/tmp/LockdownBrowser.dmg"
INSTALL_PATH="/Users/Shared/Lockdown Browser.app"

echo "Downloading Lockdown Browser..."
curl -L "$DMG_URL" -o "$DMG_PATH"

echo "Installing..."
MOUNT_POINT=$(hdiutil attach "$DMG_PATH" -nobrowse -quiet | awk 'END {print $NF}')
cp -R "$MOUNT_POINT/Lockdown Browser.app" "/Users/Shared/"
xattr -cr "$INSTALL_PATH"
hdiutil detach "$MOUNT_POINT" -quiet
rm "$DMG_PATH"

echo "Done! Lockdown Browser is installed in /Users/Shared/"
