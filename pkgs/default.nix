{pkgs, ...}: {
  thorium = pkgs.callPackage ./thorium {};
  # instant repl with automatic flake loading
  repl = pkgs.callPackage ./repl {};
  SF-Pro = pkgs.callPackage ./SF-Pro {inherit (pkgs) stdenv;};
}
