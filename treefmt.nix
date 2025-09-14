{ pkgs, ... }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";

  # Enable Nix formatter
  programs.nixfmt.enable = true;

  # Enable typst formatter
  programs.typstyle.enable = true;
}
