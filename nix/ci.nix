{ sources ? import ../npins
, pkgs ? import ./pkgs.nix { inherit sources; }
, hpkgs ? import ./hpkgs.nix { inherit pkgs; }
,
}:
let
  # The fileset filter on ../nix/hpkgs.nix already keeps the haskell
  # build from being invalidated by edits to .hlint.yaml, so we can
  # safely use the wider tree here without thrashing the cabal cache.
  src = builtins.path {
    path = ../.;
    name = "template-project-src";
    filter = path: _type:
      let base = baseNameOf (toString path);
      in !(builtins.elem base [ "dist-newstyle" "dist" "result" ".git" ]);
  };
in
{
  # The cabal build / library / executable derivation — what
  # 'nix-build' has always built. Kept here so CI builds the project
  # /and/ the hlint pass with a single 'nix-build nix/ci.nix' rather
  # than two separate invocations.
  native = import ../default.nix { inherit hpkgs; };

  # Enforce .hlint.yaml across app/src/test as part of CI. Treating
  # hlint as a derivation lets the same 'nix-build nix/ci.nix' run
  # locally and in GitHub Actions, and keeps the hlint version pinned
  # to the same nixpkgs as the rest of the toolchain.
  hlint = pkgs.runCommand "ci-hlint"
    {
      nativeBuildInputs = [ pkgs.hlint ];
    } ''
    cd ${src}
    hlint -h .hlint.yaml app src test
    touch $out
  '';
}
