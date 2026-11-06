{
  programs.neovim = {
    enable = true;
    sideloadInitLua = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withRuby = false;
    withPython3 = false;
  };
}
