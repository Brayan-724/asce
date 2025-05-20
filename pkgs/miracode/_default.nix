{ pkgs, stdenv, lib, fetchurl, ... }: let
  version = "1.0";
in
  stdenv.mkDerivation {
    pname = "miracode-nerd-font";
    inherit version;

    src = fetchurl {
      url = "https://github.com/IdreesInc/Miracode/releases/download/v${version}/Miracode.ttf";
      hash = "sha256-Q+/D/TPlqOt779qYS/dF7ahEd3Mm4a4G+wdHB+Gutmo=";
    };

    nativeBuildInputs = with pkgs; [
      nerd-font-patcher
    ];

    dontUnpack = true;
    dontConfigure = true;
    dontCheck = true;

    buildPhase = ''
      mkdir -p $out
      nerd-font-patcher -out $out/build -c $src
    '';

    installPhase = ''
      install -Dm644 $src $out/share/fonts/truetype/Miracode.ttf
      install -Dm644 $out/build/MiracodeNerdFont-Regular.ttf $out/share/fonts/truetype/MiracodeNerdFont-Regular.ttf
    '';

    meta = with lib; {
      description = "Sharp, readable, vector-y version of Monocraft";
      homepage = "https://github.com/IdreesInc/Miracode";
      license = licenses.ofl;
      platforms = platforms.all;
      maintainers = with maintainers; [coca];
    };
  }
