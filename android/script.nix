{pkgs}:
pkgs.writeShellScriptBin "emulator" ''
  export ANDROID_HOME=${pkgs.android-tools}
  export ANDROID_SDK_ROOT=$ANDROID_HOME
  export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH

  # Create AVD if it doesn't exist
  if [ ! -d "$HOME/.android/avd/test.avd" ]; then
    echo "Creating AVD..."
    echo "no" | $ANDROID_HOME/cmdline-tools/latest/bin/avdmanager create avd \
      -n test \
      -k "system-images;android-30;google_apis_playstore;x86_64" \
      -f
  fi

  # Start emulator
  echo "Starting Android emulator..."
  $ANDROID_HOME/emulator/emulator \
    -avd test \
    -no-window \
    -no-audio \
    -gpu swiftshader_indirect \
    -camera-back none \
    -camera-front none \
    -memory 2048 \
    -partition-size 4096 \
    &

  EMULATOR_PID=$!
  echo "Emulator started with PID: $EMULATOR_PID"

  # Wait for device to boot
  echo "Waiting for device to boot..."
  $ANDROID_HOME/platform-tools/adb wait-for-device
  
  # Wait for boot to complete
  while [ "$($ANDROID_HOME/platform-tools/adb shell getprop sys.boot_completed 2>/dev/null)" != "1" ]; do
    echo "Waiting for boot to complete..."
    sleep 2
  done
  
  echo "Android emulator is ready!"
  
  # Setup scrcpy server
  echo "Setting up scrcpy server..."
  $ANDROID_HOME/platform-tools/adb push ${./scrcpy-server-v2.5.jar} /data/local/tmp/scrcpy-server.jar
  $ANDROID_HOME/platform-tools/adb shell chmod 755 /data/local/tmp/scrcpy-server.jar
  
  echo "Setup complete. Emulator is running."
  wait $EMULATOR_PID
''