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
          android = pkgs.callPackage ./backend/android/docker.nix { inherit pkgs; };
          default = android;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
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
