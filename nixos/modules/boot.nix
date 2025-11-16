{ pkgs, config, ... }:
{
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
    extraModulePackages = with config.boot.kernelPackages; [
      rtl88xxau-aircrack
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      timeout = null;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = "2715x1527"; # for 4k: 3840x2160
        gfxmodeBios = "2715x1527"; # for 4k: 3840x2160
        theme = pkgs.stdenv.mkDerivation {
          pname = "distro-grub-themes";
          version = "3.1";
          src = pkgs.fetchFromGitHub {
            owner = "AdisonCavani";
            repo = "distro-grub-themes";
            rev = "v3.1";
            hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
          };
          installPhase = "cp -r customize/nixos $out";
        };
      };
    };
  };

}
