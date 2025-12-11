#!/bin/bash
set -e

USER_NAME="iot"

echo "=== Setup P2: Single-node K3s cluster ==="
echo "=== Applying network configuration ==="

# Define network from p2/network2.xml
NETWORK_XML="$(dirname "$0")/network2.xml"

if [ ! -f "$NETWORK_XML" ]; then
    echo "❌ Network file not found: $NETWORK_XML"
    exit 1
fi

# Apply network configuration
sudo virsh net-define "$NETWORK_XML" || true
sudo virsh net-start vagrant-nat-net || true
sudo virsh net-autostart vagrant-nat-net || true

echo "✅ Network configured"
echo ""
echo "Now you can start the VM with:"
echo "   cd $(dirname "$0")"
echo "   vagrant up --provider=libvirt"