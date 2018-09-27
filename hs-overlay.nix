{ pkgs }:

let
src_network-simple-wss = builtins.fetchGit {
  url = "https://github.com/k0001/network-simple-wss";
  rev = "e03bd9329babfbc4f9797c41ac7574368921cb28";
};

in
# This expression can be used as a Haskell package set `packageSetConfig`:
pkgs.lib.composeExtensions
  (import "${src_network-simple-wss}/hs-overlay.nix" { inherit pkgs; })
  (self: super: {
     pipes-network-wss = super.callPackage ./pkg.nix {};
  })
