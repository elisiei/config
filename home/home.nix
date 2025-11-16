{
  imports = [
    ./packages.nix

    # hyprland
    ./modules/hyprland/default.nix

    # editors
    ./modules/ide/nvim/default.nix
    # ./modules/ide/micro/default.nix

    # terminal stuff
    ./modules/terminal/foot/default.nix

    # shell stuff
    ./modules/shell/bash/default.nix
    # ./modules/shell/nushell/default.nix
    ./modules/shell/direnv/default.nix
    ./modules/shell/fish/default.nix

    # user stuff
    # ./modules/user/wofi/default.nix # deprecated, i use tofi now.
    ./modules/user/tofi/default.nix
    ./modules/user/dunst/default.nix
    ./modules/user/git/default.nix
    # ./modules/user/obs/default.nix
  ];

  home.username = "elisiei";
  home.homeDirectory = "/home/elisiei";
  home.stateVersion = "25.05";

  # workaround
  nixpkgs.config.allowUnfreePredicate = _: true;

  programs.home-manager.enable = true;
}
