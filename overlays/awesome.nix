final: prev: {
  awesome-git = prev.awesome.overrideAttrs (old: {
    # https://github.com/awesomeWm/awesome
    src = final.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "ad0290b"; # Jun 6, 2024
      sha256 = "sha256-uaskBbnX8NgxrprI4UbPfb5cRqdRsJZv0YXXshfsxFU=";
    };

    patches = [];

    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
    '';
  });
}
