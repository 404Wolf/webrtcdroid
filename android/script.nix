{ pkgs }:
let
  android-env = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "8.0";
    toolsVersion = "26.1.1";
    platformToolsVersion = "34.0.5";
    buildToolsVersions = [ "33.0.1" ];
    includeEmulator = true;
    emulatorVersion = "33.1.4";
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

in
pkgs.writeShellApplication {
  name = "emulator";
  runtimeInputs = [ android-env.emulator android-env.androidsdk ];
  text = 
    #bash
    ''
  export ANDROID_HOME="${android-env.androidsdk}"
  export ANDROID_SDK_ROOT="$ANDROID_HOME"

  # Create AVD if it doesn't exist
  if [ ! -d "$HOME/.android/avd/test.avd" ]; then
    echo "Creating AVD..."
    echo "no" | avdmanager create avd \
      -n test \
      -k "system-images;android-30;google_apis_playstore;x86_64" \
      -f
  fi

  # Start emulator
  echo "Starting Android emulator..."
  emulator \
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
  adb wait-for-device

  # Wait for boot to complete
  while [ "$(adb shell getprop sys.boot_completed 2>/dev/null)" != "1" ]; do
    echo "Waiting for boot to complete..."
    sleep 2
  done

  echo "Android emulator is ready!"

  # Setup scrcpy server
  echo "Setting up scrcpy server..."
  adb push ${./scrcpy-server-v2.5.jar} /data/local/tmp/scrcpy-server.jar
  adb shell chmod 755 /data/local/tmp/scrcpy-server.jar

  echo "Setup complete. Emulator is running."
  wait $EMULATOR_PID
'';
}
