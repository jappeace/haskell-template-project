{
    pkgs ? import ./pin.nix {}, ...
}:
{
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/haskell-packages.nix#L47
  ghc-def = import ../default.nix { inherit pkgs; };
  ghc-810 = import ../default.nix {compiler = "ghc8102"; inherit pkgs;};
  # ghc-901 = import ../default.nix {compiler = "ghc901"; inherit pkgs;};
  # test = pkgs.nixosTest nix/test.nix;
}
