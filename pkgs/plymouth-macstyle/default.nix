{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  pname = "mac-style";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "SergioRibera";
    repo = "s4rchiso-plymouth-theme";
    rev = "2f782f4b68ce1c00cef3fde6970d7b4241bb97d4";
    sha256 = "sha256-yOvZ4F5ERPfnSlI/Scf9UwzvoRwGMqZlrHkBIB3Dm/w=";
  };

  buildInputs = with pkgs; [git];

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/mac-style
    cp -r src/mac-style $out/share/plymouth/themes/
    chmod +x $out/share/plymouth/themes/mac-style/mac-style.plymouth
    substituteInPlace $out/share/plymouth/themes/mac-style/mac-style.plymouth --replace '@IMAGES@' "$out/share/plymouth/themes/mac-style/images/"
  '';
}
