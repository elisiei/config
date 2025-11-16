{ pkgs, ... }:
{
  users.users.elisiei = {
    isNormalUser = true;
    description = "elisiei";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
    shell = pkgs.fishMinimal;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
