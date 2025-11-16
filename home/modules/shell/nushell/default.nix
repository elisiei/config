{
  home.file.".config/nushell/config".source = ./config;
  programs.nushell = {
    enable = false;
    configFile.source = ./config.nu;
    shellAliases = {
      cls = "clear";
      nv = "nvim";
      ls = "lse";
    };
  };
}
