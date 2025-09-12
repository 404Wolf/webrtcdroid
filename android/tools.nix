{pkgs, ...}:
pkgs.androidenv.composeAndroidPackages {
  cmdLineToolsVersion = "8.0";
  toolsVersion = "26.1.1";
  platformToolsVersion = "34.0.4";
  buildToolsVersions = ["33.0.1"];
  includeEmulator = false;
  emulatorVersion = "30.3.4";
  platformVersions = ["34"];
  includeSources = false;
  includeSystemImages = false;
  systemImageTypes = ["google_apis_playstore"];
  abiVersions = ["armeabi-v7a" "arm64-v8a"];
  cmakeVersions = ["3.10.2" "3.22.1"];
  includeNDK = true;
  ndkVersions = ["25.1.8937393"];
  useGoogleAPIs = false;
  useGoogleTVAddOns = false;
  includeExtras = ["extras;google;gcm"];
}
