#!/bin/bash
# Installs Lockdown Browser on a student Mac.
# Usage:  curl -fsSL https://raw.githubusercontent.com/margarettanzosh/lockdown-browser/main/install.sh | bash
set -e

VERSION="1.2.2"
DMG_URL="https://github.com/margarettanzosh/lockdown-browser/releases/download/v${VERSION}/LockdownBrowser-${VERSION}-universal.dmg"
DMG_PATH="/tmp/LockdownBrowser.dmg"
MOUNT_POINT="/tmp/lbmount"
INSTALL_DIR="/Users/Shared"
APP_PATH="${INSTALL_DIR}/Lockdown Browser.app"

echo "Downloading Lockdown Browser ${VERSION}..."
curl -fL "$DMG_URL" -o "$DMG_PATH"

echo "Installing..."
hdiutil attach "$DMG_PATH" -nobrowse -quiet -mountpoint "$MOUNT_POINT"
rm -rf "$APP_PATH"
cp -R "${MOUNT_POINT}/Lockdown Browser.app" "$INSTALL_DIR/"
hdiutil detach "$MOUNT_POINT" -quiet
rm -f "$DMG_PATH"

# The app is signed with a Developer ID and notarized by Apple, so Gatekeeper
# should accept it as-is. This just confirms that on this machine.
if spctl --assess --type execute "$APP_PATH" 2>/dev/null; then
  echo "Gatekeeper check: OK (signed and notarized)"
else
  echo "WARNING: Gatekeeper did not accept this build. It may be unsigned or not notarized."
  echo "         Ask your teacher for help before opening it."
fi

echo "Done! Lockdown Browser is installed at: $APP_PATH"
