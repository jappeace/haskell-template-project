# https://github.com/input-output-hk/haskell.nix/blob/master/docs/tutorials/getting-started-flakes.md
{
  description = "My Haskell project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # `haskellPackages` contains all Haskell packages provided by Nixpkgs
      # for the current system and GHC version.
      pkgs = nixpkgs.legacyPackages.x86_64-linux.haskell.packages.ghc943.override {
        overrides = self: super: {
          # Add any project-specific dependencies here
          # myDep = nixpkgs.pkgs.myDep;
        };
      };
    in
    {
      defaultPackage.x86_64-linux =  pkgs.callCabal2nix "my-project" ./. { };
    };
}
