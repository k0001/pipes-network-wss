{ pkgs }:

let
src_network-simple-wss = builtins.fetchGit {
  url = "https://github.com/k0001/network-simple-wss";
  rev = "19ec519a83172975f8cb327091b2b85808dbfdbf";
};

in
# This expression can be used as a Haskell package set `packageSetConfig`:
pkgs.lib.composeExtensions
  (import "${src_network-simple-wss}/hs-overlay.nix" { inherit pkgs; })
  (self: super: {
     pipes-network-wss = super.callPackage ./pkg.nix {};
  })
