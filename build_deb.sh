#!/bin/bash
# Build roboto-all Debian package (Metapackage)
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PACKAGE="roboto-all"
VERSION="1.0.0"
ARCH="all"
DEB_DIR="${PACKAGE}_${VERSION}_${ARCH}"

echo ">>> Building ${PACKAGE} ${VERSION} (${ARCH})"

# Clean previous artifacts
rm -rf "${DEB_DIR}" "${DEB_DIR}.deb"
mkdir -p "${DEB_DIR}/DEBIAN"

# Generate Control file
# This metapackage depends on all individual sub-packages.
cat > "${DEB_DIR}/DEBIAN/control" <<EOF
Package: ${PACKAGE}
Version: ${VERSION}
Architecture: ${ARCH}
Maintainer: RoboParty <2321901849@qq.com>
Section: metapackages
Priority: optional
Depends: roboto-base (>= 1.0.0),
         roboto-bms (>= 1.0.0),
         roboto-imu (>= 1.0.0),
         roboto-motors (>= 1.0.0),
         roboto-py-example (>= 1.0.0)
Description: Metapackage for full RoboParty robot software stack.
 This package installs the complete set of RoboParty software components:
  * roboto-base: System configuration and common dependencies
  * roboto-bms: Battery Management System daemon
  * roboto-imu: IMU drivers and tools
  * roboto-motors: Motor control drivers
  * roboto-py-example: Python examples and tools
EOF

chmod 644 "${DEB_DIR}/DEBIAN/control"

# Build deb
echo ">>> Executing dpkg-deb build..."
dpkg-deb --root-owner-group --build "${DEB_DIR}"

echo ">>> Success! Generated ${DEB_DIR}.deb"
