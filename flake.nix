{
  description = "Browser Phone - Android in the browser with WebRTC";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    typix.url = "github:loqusion/typix";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      typix,
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

        watch-script = typix.lib.${system}.watchTypstProject typix-config;
        typix-config = {
          typstSource = "./srs.typ";
          fontPaths = [
            "${pkgs.roboto}/share/fonts/truetype"
          ];
        };
      in
      {
        packages = {
          default = pkgs.callPackage ./android/docker.nix { inherit pkgs; };
          srs = typix.lib.${system}.buildTypstProject typix-config;
        };

        apps = {
          srs = {
            type = "app";
            program = pkgs.lib.getExe watch-script;
          };
        };

        devShells.default = typix.lib.${system}.devShell {
          fontPaths = [
            "${pkgs.roboto}/share/fonts/truetype"
          ];
          packages = [
            watch-script
          ] ++ (with pkgs; [
            nil
            tcpdump
            scrcpy
            android-tools
            nixfmt
          ]);
        };
      }
    );
}
