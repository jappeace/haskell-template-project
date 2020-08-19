let 
pinnedPkgs = 
    (builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "nixos-pin-19.08.2020";
    url = https://github.com/nixos/nixpkgs/;
    rev = "f7651718b5966be91c4d9a6bbcbd468bd7d17bc8";
    }) ;
in
import pinnedPkgs {
    # since I also use this for clients I don't want to have to care
    config.allowUnfree = true; # took me too long to figure out
}
