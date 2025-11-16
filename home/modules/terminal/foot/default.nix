{ config, ... }:
{
  home.file.".config/foot/themes".source = ./themes;
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "fish";
        pad = "0x0center";
        font = "Maple Mono NF:size=12";
        include = "${config.xdg.configHome}/foot/themes/kanagawa.ini";
      };
      scrollback = {
        lines = 100000;
      };
    };
  };
}
