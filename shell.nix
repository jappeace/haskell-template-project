let
  def = import ./default.nix { };
in
def.hpkgs.shellFor {
  packages = ps: [ ps."template-project" ];
  withHoogle = false;

  buildInputs = [
    def.hpkgs.haskell-language-server
    def.pkgs.ghcid
    def.pkgs.cabal-install
  ];
}
