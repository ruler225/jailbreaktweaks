#!/bin/bash

# This script was made by /u/GoldDavid

usage () {
  echo "usage: $0 <deb file>"
  echo "  copies dylibs, plists, and preferences bundles from the .deb file to"
  echo "  your iPhone for use with Electra"
  echo ""
  echo "usage: $0 (while in a theos project dir)"
  echo "  copies dylibs, plists, and preferences bundles from your last built"
  echo "  .deb file to your iPhone for use with Electra"
  exit 1
}

# Change these to your device's IP address and port or set THEOS_DEVICE_IP and
# THEOS_DEVICE_PORT via your shell profile.
readonly DEVICE_IP="${THEOS_DEVICE_IP}"
readonly DEVICE_PORT="${THEOS_DEVICE_PORT}"

if [[ $# -gt 1 ]]; then
  usage
fi
if [[ $# -eq 1 ]]; then
  readonly DEB="$1"
else
  echo "Checking if this is a theos project dir..."
  if [[ ! -f .theos/last_package ]]; then
    usage
  fi
  echo "Found .theos/last_package, making sure it points to a valid package..."
  readonly DEB=$(cat .theos/last_package)
  if [[ -z "${DEB}" ]] || [[ ! -f "${DEB}" ]]; then
    echo "Invalid last_package \"${DEB}\", cannot install as it doesn't exist."
    exit 1
  fi
  echo "Using deb at \"${DEB}\"..."
fi

readonly TMPFOLDER=$(mktemp -d)
trap "rm -rf ${TMPFOLDER}" EXIT

dpkg -x "${DEB}" "${TMPFOLDER}"

# Copy files from ./Library/MobileSubstrate/DynamicLibraries into /bootstrap/Library/SBInject.
if [[ -d ${TMPFOLDER}/Library/MobileSubstrate/DynamicLibraries ]]; then
  echo "Copying tweak dylibs and plists..."
  scp -P "${DEVICE_PORT}" ${TMPFOLDER}/Library/MobileSubstrate/DynamicLibraries/* "root@${DEVICE_IP}":/bootstrap/Library/SBInject/
fi

# Copy files from ./Library/PreferenceBundles into /bootstrap/PreferenceBundles.
if [[ -d ${TMPFOLDER}/Library/PreferenceBundles ]]; then
  echo "Copying preference bundles..."
  scp -P "${DEVICE_PORT}" -pr ${TMPFOLDER}/Library/PreferenceBundles/*/ "root@${DEVICE_IP}":/bootstrap/Library/PreferenceBundles/
fi
# Copy files from ./Library/PreferenceLoader into /bootstrap/PreferenceLoader.
if [[ -d ${TMPFOLDER}/Library/PreferenceLoader ]]; then
  echo "Copying preference loader plists..."
  scp -P "${DEVICE_PORT}" -pr ${TMPFOLDER}/Library/PreferenceLoader/*/ "root@${DEVICE_IP}":/bootstrap/Library/PreferenceLoader/
fi

# Copy files from ./usr/lib into /usr/lib.
if [[ -d ${TMPFOLDER}/usr/lib ]]; then
  echo "Copying libs..."
  scp -P "${DEVICE_PORT}" ${TMPFOLDER}/usr/lib/* "root@${DEVICE_IP}":/usr/lib/
fi
