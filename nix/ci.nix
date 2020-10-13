{
    pkgs ? import ./pin.nix {}, ...
}:
{
  ghc-def = import ../default.nix { inherit pkgs; };
  ghc-865 = import ../default.nix {compiler = "ghc865"; inherit pkgs; };
  ghc-883 = import ../default.nix {compiler = "ghc883"; inherit pkgs;};
  ghc-810 = import ../default.nix {compiler = "ghc8101"; inherit pkgs;};
  # test = pkgs.nixosTest nix/test.nix;
}
