{ lib, stdenv, ... }:
stdenv.mkDerivation {
  pname = "miracode-complete";
  version = "1.0";

  src = ./.;

  configurePhase = ''
    fontname="Miracode"

    function installFont () {
      this_font=$fontname$1
      this_font_nerd=$fontname"NerdFont-"$1

      install -Dm644 $src/$this_font.ttf $out/share/fonts/truetype/$this_font.ttf
      install -Dm644 $src/$this_font.otf $out/share/fonts/opentype/$this_font.otf

      install -Dm644 $src/$this_font_nerd.ttf $out/share/fonts/truetype/$this_font_nerd.ttf
      install -Dm644 $src/$this_font_nerd.otf $out/share/fonts/opentype/$this_font_nerd.otf
    }
  '';

  installPhase = ''
    installFont Black
    installFont Bold
    installFont SemiBold
    installFont Normal
    installFont Medium
    installFont Light
    installFont ExtraLight
    installFont Thin
  '';

  meta = with lib; {
    description = "Sharp, readable, vector-y version of Monocraft";
    homepage = "https://github.com/IdreesInc/Miracode";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
