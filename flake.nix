# I used chatgpt to generate this template and then just
# modified to how I normally use these things.
{
  description = "My Haskell project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    wasm.url = "tarball+https://gitlab.haskell.org/ghc/ghc-wasm-meta/-/archive/master/ghc-wasm-meta-master.tar.gz";
  };

  outputs = { self, nixpkgs, flake-compat, wasm }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      hpkgs = pkgs.haskellPackages.override {
        overrides = hnew: hold: {
          template-project = hnew.callCabal2nix "template-project" ./. { };
        };
      };
    in
    {
      defaultPackage.x86_64-linux =  hpkgs.template-project;
      inherit pkgs;
      inherit wasm;
      devShell.x86_64-linux = hpkgs.shellFor {
        packages = ps : [ ps."template-project" ];
        withHoogle = true;

        buildInputs = [
          wasm.packages.x86_64-linux.cabal
        ];
      };
    };
}
