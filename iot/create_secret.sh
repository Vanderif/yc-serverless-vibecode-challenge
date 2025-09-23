#!/bin/bash

# This script creates a Yandex Lockbox secret named 'iot'
# and adds a version with credentials for an IoT Core device.

echo "Creating empty Lockbox secret 'iot'..."

# Use the YC CLI to create the empty secret
yc lockbox secret create \
  --name iot \
  --description "Credentials for IoT device"

# Check the exit code of the yc command
if [ $? -ne 0 ]; then
  echo "Error: Failed to create empty secret 'iot'."
  exit 1
fi

echo "Secret 'iot' created. Adding a new version with keys..."

# Download the root certificate and escape newlines for JSON
cert_content=$(curl -s https://storage.yandexcloud.net/mqtt/rootCA.crt | awk '{printf "%s\\n", $0}')

# Create the JSON payload and pipe it to the add-version command
cat <<EOF | yc lockbox secret add-version --name iot --payload -
[
  {
    "key": "root-ca",
    "text_value": "${cert_content}"
  },
  {
    "key": "device-id",
    "text_value": "aregdl4k2vtetdqgsavf"
  },
  {
    "key": "registry-id",
    "text_value": "arec31n44f1r1rrgf1qm"
  },
  {
    "key": "registry-password",
    "text_value": "my-iot-registry-1234"
  }
]
EOF

# Check the exit code of the last command
if [ $? -eq 0 ]; then
  echo "New version added to secret 'iot' successfully."
else
  echo "Error: Failed to add new version to secret 'iot'."
fi

echo "Script finished."