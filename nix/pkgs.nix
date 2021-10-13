import ./pin.nix {
  config = {

    packageOverrides = pkgs: {
        haskell = pkgs.lib.recursiveUpdate pkgs.haskell {
        packageOverrides = hpNew: hpOld: {
            template = hpNew.callPackage ../default.nix {};
            };
        };
    };
  };
}
