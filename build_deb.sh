#!/bin/bash
# Build roboto-all Debian package (Metapackage)
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Determine Board Type
# Usage: ./build_deb.sh [robopi1|robopi2]
BOARD=${1:-"robopi2"}
CONFIG_FILE="${SCRIPT_DIR}/${BOARD}.txt"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file $CONFIG_FILE not found!"
    echo "Usage: $0 [robopi1|robopi2]"
    exit 1
fi

# Package name stays constant so 'apt install roboto-all' works
PACKAGE="roboto-all"
VERSION="1.1.0"
ARCH="all"
# We include the board in the directory/filename only for artifact distinction
DEB_DIR="${PACKAGE}_${VERSION}_${BOARD}_${ARCH}"

echo ">>> Building ${PACKAGE} ${VERSION} for ${BOARD} (Config: ${BOARD}.txt)"

# 2. Read dependencies and format for Debian control file
DEPENDS=$(grep -v '^$' "$CONFIG_FILE" | paste -sd "," - | sed 's/,/, /g')

# Clean previous artifacts
rm -rf "${DEB_DIR}" "${DEB_DIR}.deb"
mkdir -p "${DEB_DIR}/DEBIAN"

# 3. Generate Control file
cat > "${DEB_DIR}/DEBIAN/control" <<EOF
Package: ${PACKAGE}
Version: ${VERSION}
Architecture: ${ARCH}
Maintainer: RoboParty <2321901849@qq.com>
Section: metapackages
Priority: optional
Depends: ${DEPENDS}
Description: Metapackage for RoboParty robot software stack (${BOARD} version)
 This package is tailored for ${BOARD} and installs:
$(sed 's/^/  * /' "$CONFIG_FILE")
EOF

chmod 644 "${DEB_DIR}/DEBIAN/control"

# 4. Build deb
echo ">>> Executing dpkg-deb build for ${BOARD}..."
dpkg-deb --root-owner-group --build "${DEB_DIR}"

# Rename the resulting .deb to include the board name for clarity
mv "${DEB_DIR}.deb" "${PACKAGE}_${VERSION}_${BOARD}.deb"

echo ">>> Success! Generated ${PACKAGE}_${VERSION}_${BOARD}.deb"
