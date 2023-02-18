# https://github.com/input-output-hk/haskell.nix/blob/master/docs/tutorials/getting-started-flakes.md
{
  description = "My Haskell project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      hpkgs = pkgs.haskell.packages.ghc943.override {
        overrides = hold: hnew: {
          template-project = hnew.callCabal2nix "template-project" ./. { };
        };
      };
    in
    {
      defaultPackage.x86_64-linux =  hpkgs.template-project;
      devShell.x86_64-linux = hpkgs.shellFor {
        packages = ps : [ ps."template-project" ];
        buildInputs = [
          pkgs.cabal-install
        ];
      };
    };
}
