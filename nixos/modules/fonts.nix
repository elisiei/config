{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.noto
      nerd-fonts.jetbrains-mono
      maple-mono.NF
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Nerd Font" ];
      sansSerif = [ "Noto Nerd Font" ];
      monospace = [ "Noto Nerd Font" ];
    };
  };
}
