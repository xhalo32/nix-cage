{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    with flake-utils.lib; eachSystem [
      system.x86_64-linux
      system.aarch64-linux
    ] (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          packages = rec {
            default = nix-cage;
            nix-cage = pkgs.callPackage (import ./default.nix) {};
          };
        }

    );
}
