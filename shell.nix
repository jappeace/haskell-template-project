{
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/haskell-packages.nix
  pkgs ? import ./nix/pkgs.nix
}:
#  https://input-output-hk.github.io/haskell.nix/tutorials/development/
pkgs.haskellPackages.shellFor {
  packages = ps : [ ps.template ];
  buildInputs = [
        pkgs.ghcid
        pkgs.cabal-install
        ];
  exactDeps = true;
  NIX_PATH="nixpkgs=${pkgs.path}:.";
}
