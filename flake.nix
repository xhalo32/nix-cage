{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      flake-utils,
    }:
    with flake-utils.lib;
    eachSystem
      [
        system.x86_64-linux
        system.aarch64-linux
      ]
      (
        system:
        let
          sources = import ./npins;
          pkgs = import sources.nixpkgs {
            inherit system;
            config = { };
            overlays = [ ];
          };
        in
        {
          packages = rec {
            default = nix-cage;
            nix-cage = pkgs.callPackage (import ./package.nix) { };
          };
        }

      );
}
