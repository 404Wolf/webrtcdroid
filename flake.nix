{
  description = "Browser Phone - Android in the browser with WebRTC";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
      in
      {
        packages = rec {
 android-env = (pkgs.androidenv.composeAndroidPackages {
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
  }).emulator;         android = pkgs.callPackage ./android/docker.nix { inherit pkgs; };
          default = android;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            typst
            vlc
            tcpdump
            scrcpy
            android-tools
            nixfmt
          ];
        };
      }
    );
}
