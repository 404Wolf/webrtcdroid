{ pkgs }:
let
  script = pkgs.callPackage ./script.nix { };
in
pkgs.dockerTools.buildImage {
  name = "android-emulator";
  tag = "latest";
  contents = [
    pkgs.busybox
    script
  ];
  config = {
    Cmd = [ "${script}/bin/emulator" ];
  };
}
