#!/bin/bash
set -e

DMG_URL="https://github.com/margarettanzosh/lockdown-browser/releases/download/v1.0.0/Lockdown.Browser-1.0.0-arm64.dmg"
DMG_PATH="/tmp/LockdownBrowser.dmg"
INSTALL_PATH="/Users/Shared/Lockdown Browser.app"

echo "Downloading Lockdown Browser..."
curl -L "$DMG_URL" -o "$DMG_PATH"

echo "Installing..."
hdiutil attach "$DMG_PATH" -nobrowse -mountpoint /tmp/lbmount
echo "Mounted. Contents:"
ls /tmp/lbmount/
cp -R "/tmp/lbmount/Lockdown Browser.app" "/Users/Shared/"
xattr -cr "$INSTALL_PATH"
hdiutil detach /tmp/lbmount -quiet
rm "$DMG_PATH"

echo "Done! Lockdown Browser is installed in /Users/Shared/"
