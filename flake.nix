# https://github.com/input-output-hk/haskell.nix/blob/master/docs/tutorials/getting-started-flakes.md
{
  description = "Haskell template project";
  inputs = {
    haskellNix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskellNix/nixpkgs-2205";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachSystem [
      "x86_64-linux"
      "x86_64-darwin"
    ] (system:
    let
      overlays = [
        (haskellNix.overlay
          (

        builtins.trace "over"
            (final: prev: {
          # This overlay adds our project to pkgs
          template = builtins.trace "templateeee"
            final.haskell-nix.project' {
              src = ./.;
              compiler-nix-name = "ghc924";
              # This is used by `nix develop .` to open a shell for use with
              # `cabal`, `hlint` and `haskell-language-server`
              shell.tools = {
                cabal = {};
                hlint = {};
                hasktags  = {};
                ghcid = {};
                # haskell-language-server = {};
              };
              # Non-Haskell shell tools go here
              shell.buildInputs = [
              ];
            };
            })))
      ];
      # TODO this import is wrong.
      # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/3
      pkgs = builtins.foldl'
        (acc: overlay:
          acc.lib.extends overlay)
              nixpkgs.legacyPackages.${system}
              overlays;
      flake = pkgs.template.flake {};

    in pkgs.lib.recursiveUpdate flake {
      # Built by `nix build .`
      # "${system}".default = flake.packages."template:exe:exe";
      defaultPackage = flake.packages."template:exe:exe";
    });
}
