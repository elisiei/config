{
  imports = [
    # user stuff
    ./modules/user/wofi/default.nix
    ./modules/user/dunst.nix
    ./modules/user/git.nix
    ./modules/user/obs.nix
    ./modules/packages.nix

    # wm
    ./modules/wm/hyprland/default.nix

    # terminals
    ./modules/terminal/alacritty/default.nix

    # ides
    ./modules/ide/nvim/default.nix

    # shell stuff
    ./modules/shell/bash/default.nix
    ./modules/shell/nushell/default.nix

    # nix env
    ./modules/env/direnv/default.nix
  ];

  home.username = "ye";
  home.homeDirectory = "/home/ye";
  home.stateVersion = "25.05";

  # workaround
  nixpkgs.config.allowUnfreePredicate = _: true;

  programs.home-manager.enable = true;
}
