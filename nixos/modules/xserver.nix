{ config, ... }:
{
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false; # closed-source driver
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  console.keyMap = "es";

  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland-uwsm";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "elisiei";
  services.displayManager.sddm.wayland.enable = true;

  environment.etc."xdg/sessions/hyprland.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland
    Comment=Hyprland Wayland Compositor
    Exec=Hyprland
    Type=Application
  '';
}
