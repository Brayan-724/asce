{pkgs, ...}: {
  nixos.fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      SF-Pro

      # Monospaced
      maple-mono.NF-CN
      miracode

      # nerdfonts
      nerd-fonts.geist-mono
      nerd-fonts.zed-mono
      nerd-fonts.symbols-only
      nerd-fonts.victor-mono
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };
      defaultFonts = {
        serif = ["SF Pro Text" "Noto Color Emoji"];
        sansSerif = ["SF Pro Display" "Noto Color Emoji"];
        monospace = ["GeistMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };
}
