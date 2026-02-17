{
  pkgs,
  ...
}: let
in
  pkgs.stdenv.mkDerivation rec {
    name = "kotlin-lsp";
    version = "261.13587.0";

    src = pkgs.fetchzip {
      url = "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-lsp-${version}-linux-x64.zip";
      hash = "sha256-EweSqy30NJuxvlJup78O+e+JOkzvUdb6DshqAy1j9jE=";
      stripRoot = false;
    };

    installPhase = ''
      mkdir -p $out

      cp -r --no-preserve=mode $src $out/src
      chmod +x $out/src/jre/bin/java
      chmod +x $out/src/kotlin-lsp.sh

      mkdir -p $out/bin
      ln -s $out/src/kotlin-lsp.sh $out/bin/kotlin-lsp
    '';
  }
