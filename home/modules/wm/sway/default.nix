{
  config,
  pkgs,
  lib,
  ...
}:
let
  wallpaperScript = pkgs.writeShellScriptBin "random-wallpaper" ''
    WALP=$(find "$HOME/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
    [ -n "$WALP" ] && ${pkgs.swaybg}/bin/swaybg -i "$WALP" --mode fill &
  '';
in
{
  home.packages = [
    wallpaperScript
  ];

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;

    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      menu = "exec $(tofi-drun)";

      # monitor configuration
      output = {
        "*" = {
          resolution = "1920x1080";
          scale = "1";
        };
      };

      # startup commands
      startup = [
        { command = "${wallpaperScript}/bin/random-wallpaper"; }
      ];

      # input configuration
      input = {
        "type:keyboard" = {
          xkb_layout = "es,ru";
          xkb_options = "grp:alt_space_toggle";
          xkb_numlock = "enabled";
        };
      };

      # window appearance
      gaps = {
        inner = 0;
        outer = 0;
      };

      window = {
        border = 0;
      };

      floating = {
        border = 0;
      };

      # focus settings
      focus = {
        followMouse = true;
      };

      # keybindings
      keybindings = lib.mkOptionDefault {
        # screenshots
        "${modifier}+Shift+Print" = "exec ~/bin/grimblast copy screen";
        "${modifier}+Print" = "exec ~/bin/grimblast copy area";

        # application launchers
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+w" = "exec ${wallpaperScript}/bin/random-wallpaper";
        "${modifier}+s" = "sticky toggle";
        "${modifier}+t" = "exec ${terminal}";
        "${modifier}+z" = "exec librewolf";

        # Window management
        "${modifier}+q" = "kill";
        "${modifier}+Shift+m" = "exit";
        "${modifier}+v" = "floating toggle";

        # focus movement
        "${modifier}+Left" = "focus left";
        "${modifier}+Right" = "focus right";
        "${modifier}+Up" = "focus up";
        "${modifier}+Down" = "focus down";

        # workspace switching
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        # move to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
      };

      # mouse bindings for moving/resizing windows
      modes = {
        resize = {
          Left = "resize shrink width 10 px";
          Right = "resize grow width 10 px";
          Up = "resize shrink height 10 px";
          Down = "resize grow height 10 px";
          Escape = "mode default";
          Return = "mode default";
        };
      };

      bars = [ ];
    };

    extraConfig = ''
      # window borders
      default_border pixel 0
      default_floating_border pixel 0

      # mouse bindings
      floating_modifier ${config.wayland.windowManager.sway.config.modifier} normal

      # cursor theme
      seat seat0 xcursor_theme macOS 24
    '';
  };

  # environment variables
  home.sessionVariables = {
    XCURSOR_THEME = "macOS";
    XCURSOR_SIZE = "24";
  };
}
