{ pkgs }:
let
  android-env = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "8.0";
    toolsVersion = "26.1.1";
    platformToolsVersion = "34.0.4";
    buildToolsVersions = [ "33.0.1" ];
    includeEmulator = false;
    emulatorVersion = "30.3.4";
    platformVersions = [ "34" ];
    includeSources = false;
    includeSystemImages = false;
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [
      "armeabi-v7a"
      "arm64-v8a"
    ];
    cmakeVersions = [
      "3.10.2"
      "3.22.1"
    ];
    includeNDK = true;
    ndkVersions = [ "25.1.8937393" ];
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
    includeExtras = [ "extras;google;gcm" ];
  };

  androidsdkPath = android-env.androidsdk;

in
pkgs.writeShellScriptBin "emulator" ''
  export ANDROID_HOME="${androidsdkPath}"
  export ANDROID_SDK_ROOT="$ANDROID_HOME"

  # Function to check if a command exists
  command_exists () {
    command -v "$1" >/dev/null 2>&1
  }

  # Determine the correct path to avdmanager
  if command_exists "$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager"; then
    AVDMANAGER="$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager"
  elif command_exists "$ANDROID_HOME/cmdline-tools/bin/avdmanager"; then
    AVDMANAGER="$ANDROID_HOME/cmdline-tools/bin/avdmanager"
  else
    echo "Error: avdmanager not found. Please check your Android SDK installation."
    exit 1
  fi

  ADB="$ANDROID_HOME/platform-tools/adb"
  EMULATOR="$ANDROID_HOME/emulator/emulator"

  export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/cmdline-tools/bin:$PATH"

  # Create AVD if it doesn't exist
  if [ ! -d "$HOME/.android/avd/test.avd" ]; then
    echo "Creating AVD..."
    echo "no" | $AVDMANAGER create avd \
      -n test \
      -k "system-images;android-30;google_apis_playstore;x86_64" \
      -f
  fi

  # Start emulator
  echo "Starting Android emulator..."
  $EMULATOR \
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
  $ADB wait-for-device

  # Wait for boot to complete
  while [ "$($ADB shell getprop sys.boot_completed 2>/dev/null)" != "1" ]; do
    echo "Waiting for boot to complete..."
    sleep 2
  done

  echo "Android emulator is ready!"

  # Setup scrcpy server
  echo "Setting up scrcpy server..."
  $ADB push ${./scrcpy-server-v2.5.jar} /data/local/tmp/scrcpy-server.jar
  $ADB shell chmod 755 /data/local/tmp/scrcpy-server.jar

  echo "Setup complete. Emulator is running."
  wait $EMULATOR_PID
''