final: prev: {
  discord = prev.discord.override {
    withOpenASAR = true;
    commandLineArgs = "--use-gl=desktop";
  };
}
