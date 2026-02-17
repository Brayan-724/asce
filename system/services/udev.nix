{pkgs, ...}: let
  rules = pkgs.stdenv.mkDerivation {
    name = "custom-rules";

    src = ./udev;

    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      mkdir -p $out/lib/udev/rules.d
      cp 69-probe-rs.rules $out/lib/udev/rules.d
    '';
  };
in {
  services.udev.packages = [rules];
}
