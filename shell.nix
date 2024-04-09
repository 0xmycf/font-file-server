{pkgs ? import <nixpkgs> {}}:
  pkgs.mkShell {
    name = "Go Nix Shell";
    packages = with pkgs.buildPackages; [
      go
      gopls
    ];
  }
