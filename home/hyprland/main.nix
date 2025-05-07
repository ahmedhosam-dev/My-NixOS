{ config, pkgs, lib, ... }:

{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/wallpapers/wallhaven-we3r96_1920x1080.png
    wallpaper = eDP-1, ~/Pictures/wallpapers/wallhaven-we3r96_1920x1080.png
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    
    settings = {
      # Monitor configuration
      monitor = ", 1920x1080@60, 0x0, 1";

      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "GDK_BACKEND,wayland"
      ];

      # Autostart
      exec-once = [
        "waybar"
        "hyprpaper"
        "brave"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      # Input configuration
      input = {
        kb_layout = "us,ara";
        kb_options = "caps:swapescape, grp:win_space_toggle";
        follow_mouse = 1;
        sensitivity = 0;  # -1.0 to 1.0

        touchpad = {
          natural_scroll = true;
          scroll_factor = 1.0;
          tap-to-click = true;
          drag_lock = false;
          middle_button_emulation = false;
          disable_while_typing = true;
          clickfinger_behavior = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        # workspace_swipe_distance = 300;
        # workspace_swipe_invert = false;
        # workspace_swipe_min_speed_to_force = 5;
        # workspace_swipe_cancel_ratio = 0.5;
        # workspace_swipe_create_new = true;
      };

      # General appearance
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 5, default"
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
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master.new_status = "master";

      # Misc settings
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
        disable_autoreload = false;
      };

      # Keybindings
      "$mainMod" = "Super_L";
      "$mainShift" = "Super_L_SHIFT";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun";
      "$filebrowser" = "rofi -show filebrowser";
      "$emoji" = "rofimoji --action clipboard --clipboarder wl-copy";
      "$browser" = "brave";

      binds = {
        allow_workspace_cycles = true;
      };

      bind = [
        "$mainShift,      Return,     exec, $terminal"
        "$mainMod,        W,          exec, $browser"
        "$mainShift,      Q,                killactive"
        "$mainShift,      M,                exit"
        "$mainMod,        E,          exec, $fileManager"
        "$mainMod,        T,                togglefloating"
        "$mainShift,      T,                togglesplit"
        "$mainMod,        G,          exec, $menu"
        "$mainShift,      P,                pseudo"
        "$mainMod,        semicolon,  exec, $emoji"
        "$mainShift,      E,          exec, $filebrowser"
        "          ,      Print,      exec, grim -g \"$(slurp)\" - | swappy -f -"
        "$mainMod,        V,          exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        
        # Movement
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod, TAB, cyclenext"
        
        # Workspaces
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
        "$mainMod, d, workspace, previous"
        
        # Move windows
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
        
        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        
        # Mouse bindings
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        
        # Media keys
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"

        # 3-finger swipe for workspace switching
        ", swipe:3:l, workspace, e-1"
        ", swipe:3:r, workspace, e+1"
        ", swipe:3:u, exec, pkill -x rofi || rofi -show drun"  # Show app launcher
        ", swipe:3:d, togglefloating"  # Toggle floating window

        # 4-finger swipe for special workspace
        ", swipe:4:l, movetoworkspace, special"
        ", swipe:4:r, togglespecialworkspace"

        # Zoom gestures (pinch in/out)
        ", pinch:out, exec, ${pkgs.swayosd}/bin/swayosd --brightness raise && ${pkgs.hyprland}/bin/hyprctl keyword misc:cursor_zoom_factor 1.1"
        ", pinch:in, exec, ${pkgs.swayosd}/bin/swayosd --brightness lower && ${pkgs.hyprland}/bin/hyprctl keyword misc:cursor_zoom_factor 0.9"
        
        # Reset zoom level with 3-finger tap
        ", tap:3, exec, ${pkgs.hyprland}/bin/hyprctl keyword misc:cursor_zoom_factor 1.0"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrule = [
        "float, pavucontrol"
      ];

      windowrulev2 = [
        "opacity 0.8 0.8, class:^(kitty)$"
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };

    # Extra configuration for better gesture recognition
    # extraConfig = ''
    #   # Touchpad device tuning (may need adjustment for your hardware)
    #   device:touchpad {
    #     sensitivity = 0.5
    #     scroll_points = 100,200,300
    #     tap-and-drag = true
    #   }
    # '';
  };

  # Additional Hyprland-related packages
  home.packages = with pkgs; [
    grim
    slurp
    swappy
    wl-clipboard
    playerctl
    brightnessctl
    pamixer
  ];

  # If you want to split into multiple files 
  # wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hyprland-keybinds.conf;
}
