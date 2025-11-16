{ pkgs, ... }:
let
  wallpaperScript = pkgs.writeShellScriptBin "random-wallpaper" ''
    pkill swaybg 2>/dev/null || true
    WALP=$(find "$HOME/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
    [ -n "$WALP" ] && ${pkgs.swaybg}/bin/swaybg -i "$WALP" --mode fill
  '';
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${wallpaperScript}/bin/random-wallpaper
  '';
in
{
  home.packages = [ wallpaperScript ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [
        ",1920x1080,auto,1,bitdepth,8"
        ",preferred,auto,1,mirror,eDP-1,bitdepth,8"
      ];

      xwayland = {
        force_zero_scaling = "true";
      };

      exec-once = [ "${startupScript}/bin/start" ];

      "$term" = "foot";
      "$browser" = "librewolf";
      "$menu" = "exec $(tofi-drun)";

      env = [
        "XCURSOR_THEME,macOS"
        "XCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = "0";
        gaps_out = "0";
        border_size = "0";
        "col.active_border" = "rgba(0,0,0,0)";
        "col.inactive_border" = "rgba(0,0,0,0)";
        resize_on_border = "false";
        allow_tearing = "false";
        layout = "dwindle";
      };

      debug = {
        disable_logs = false;
      };

      decoration = {
        rounding = "0";
        active_opacity = "1";
        inactive_opacity = "0.95";
        shadow.enabled = false;
        blur = {
          enabled = false;
          xray = false;
          special = true;
          new_optimizations = true;
          size = 10;
          passes = 3;
          brightness = 0.9;
          noise = 2.0e-2;
          contrast = 1.1;
          popups = true;
          popups_ignorealpha = 0.5;

          vibrancy = 0.2;
          vibrancy_darkness = 0.1;
        };
      };

      animations = {
        enabled = false;
        animations = {
          bezier = [
            "easeOutQuint, 0.23, 1, 0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear, 0, 0, 1, 1"
            "almostLinear, 0.5, 0.5, 0.75, 1.0"
            "quick, 0.15, 0, 0.1, 1"
          ];
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
            "zoomFactor, 1, 7, quick"
          ];
        };
      };

      misc = {
        force_default_wallpaper = "0";
        disable_hyprland_logo = "true";
        middle_click_paste = "false";
        vfr = "true";
      };

      gestures.workspace_swipe = "false";

      device = {
        name = "epic-mouse-v1";
        sensitivity = "-0.5";
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod SHIFT, PRINT, exec, ~/bin/grimblast copy screen" # whole screen
        "$mainMod, PRINT, exec, ~/bin/grimblast copy area" # selection
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, W, exec, random-wallpaper"
        "$mainMod, S, pin"
        "$mainMod, T, exec, $term"
        "$mainMod, Z, exec, $browser"
        # "$mainMod, K, exec, st" # CHANGE THIS SDBHFDSFSFHJ
        "$mainMod, Q, killactive"
        "$mainMod SHIFT, M, exit"
        "$mainMod, V, togglefloating"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      input = {
        kb_layout = "es,ru";
        kb_options = "grp:alt_space_toggle";
        numlock_by_default = true;
      };

      bindm = [
        "$mainMod, mouse:272, movewindow" # left click
        "$mainMod, mouse:273, resizewindow" # right click
      ];

      windowrulev2 = "suppressevent maximize, class:.*";
    };
  };
}
