{
  pkgs,
  system,
}:
# I think macos has problems with this
let
  buildModule =
    if system == "x86_64-apple-darwin" || system == "x86_64-darwin" || system == "darwin"
    then pkgs.buildGoModule
    else pkgs.buildGoModule.override {stdenv = pkgs.pkgsStatic.stdenv;};
in
  buildModule rec {
    pname = "font-file-server";
    version = import ./version.nix;
    src = ./.;
    ldflags = [
      "-X main.version=${version}"
    ];

    CGO_ENABLED = 0;
    vendorHash = null; #pkgs.lib.fakeHash;

    meta = with pkgs.lib; {
      description = 
        ''A simple fileserver that I deploy on my raspberry pi
          to serve me fonts for my nix config'';
      homepage = "github.com/0xmycf/font-file-server";
      license = licenses.mit;
      maintainers = ["github.com/0xmycf"];
    };
  }
