{ sources ? import ./npins
,
}:
let
  pkgs = import sources.nixpkgs { };
  # you can pin a specific ghc version with
  # pkgs.haskell.packages.ghc984 for example.
  # this allows you to create multiple compiler targets via nix.
  hpkgs = pkgs.haskellPackages.override {
    overrides = hnew: hold: {
      template-project = hnew.callCabal2nix "template-project" ./. { };
    };
  };
in
{
  defaultPackage = hpkgs.template-project;
  hpkgs = hpkgs;
  pkgs = pkgs;
}
