{
  description = "A flake for a go project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # assuming the project also has a {default, shell.}nix
      defaultPackage = (import ./default.nix) {
        inherit pkgs;
        inherit system;
      };
      devShell = (import ./shell.nix) {inherit pkgs;};
    });
}
