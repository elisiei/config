{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    # essential
    curl

    # useful
    wl-clipboard
    gnumake
    git-credential-manager

    # notifications
    libnotify

    # screenshot utils
    grim
    slurp
    hyprpicker # not really for screenshots, but i use it to freeze screen

    # email client
    thunderbird

    # browser
    librewolf

    # wayland
    swaybg
    apple-cursor
  ];

  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false;

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
    ];
    colorScheme = "Ocean";
  };
}
