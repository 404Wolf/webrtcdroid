#!/bin/bash

echo "Setting up scrcpy server..."

# Push scrcpy server to device
$ADB push $SCRCPY_SERVER_PATH /data/local/tmp/scrcpy-server.jar
if [ $? -ne 0 ]; then
    echo "Failed to push scrcpy server"
    exit 1
fi

# Make it executable
$ADB shell chmod 755 /data/local/tmp/scrcpy-server.jar
if [ $? -ne 0 ]; then
    echo "Failed to make scrcpy server executable"
    exit 1
fi

echo "Scrcpy server setup complete"