{pkgs, ...}: {
  mac-style = pkgs.callPackage ./plymouth-macstyle {};
  miracode = pkgs.callPackage ./miracode {inherit (pkgs) stdenv;};
  # instant repl with automatic flake loading
  repl = pkgs.callPackage ./repl {};
  SF-Pro = pkgs.callPackage ./SF-Pro {inherit (pkgs) stdenv;};
}
