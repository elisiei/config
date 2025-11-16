{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    jq
    btop
    fd
    fzf
    zig
    kdePackages.dolphin
    gnome.gvfs
    discord
  ];
}
