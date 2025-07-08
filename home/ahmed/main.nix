{ config, pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.username = "ahmed";
  home.homeDirectory = "/home/ahmed";
  home.stateVersion = "24.11";

  # Import Configruations files
  imports = [
    ./hyprland/main.nix
    ./neovim/main.nix
    ./kitty.nix
    ./waybar/main.nix
  ];


  # User packages
  home.packages = with pkgs; [
    # Applications
    brave
    discord
    obsidian
    postman
    figma-linux
    spotify
    wpsoffice
    xfce.thunar
    obs-studio
    vlc vlc-bittorrent
    bottles 
    evince
    sticky-notes
    telegram-desktop
    pomodoro-gtk
    # protonmail-desktop
    
    # Utilities
    grim slurp swappy
    gnome-system-monitor
    kittysay
    fastfetch
    chafa
    gtk3 gtk4 
    tmux

    # theme
    whitesur-gtk-theme
    whitesur-icon-theme
    adw-gtk3
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      gen = "sudo nixos-rebuild switch";
      u = "sudo nixos-rebuild switch --upgrade";
      cls = "clear";
      vim = "nvim";
      enc = "doas nvim /etc/nixos/";
      meow = "kittysay";
      c = "z";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "z" "sudo" "zsh-interactive-cd" ];
    };

    plugins = [
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      source ~/.p10k.zsh
      bindkey -v

      if [[ -z "$FASTFETCH_SHOWN" ]]; then
        export FASTFETCH_SHOWN=1
        fastfetch
      fi
    '';
  };

  # Notification
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#89b4fa";
        separator_color = "frame";
        highlight = "#89b4fa";
        origin = "top-right";
        offset = "20x80";
        scale = 0;
        line_height = 4;
        transparency = 10;
        corner_radius = 8;
        font = "FantasqueSansM Nerd Font Mono 12";
        nable_recursive_icon_lookup = true;
        icon_theme = "WhiteSur-dark";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 64;
        # icon_path = "${config.home.homeDirectory}/.config/swaync/images/";
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#fab387";
      };
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "ahmedhosam-dev";
    userEmail = "ahmed0114702@email.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };


  # GTK
  gtk = {
   enable = true;
    font.name = "FantasqueSansM Nerd Font Mono 12";
  
    theme = {
      # name = "WhiteSur-Dark";  # Ensure you're using the -Dark variant
      # package = pkgs.whitesur-gtk-theme;
      name = "adw-gtk3-dark";  # Ensure you're using the -Dark variant
      package = pkgs.adw-gtk3;
    };
  
    iconTheme = {
      name = "WhiteSur-dark";  # Icon themes are case-sensitive, double-check available names
      package = pkgs.whitesur-icon-theme;
    };
  
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  
    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
      # "gtk-theme-name" = "WhiteSur-Dark";
      "gtk-theme-name" = "adw-gtk3-dark";
      "gtk-icon-theme-name" = "WhiteSur-dark";
      "gtk-cursor-theme-name" = "Bibata-Modern-Ice";
    };

    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
      # "gtk-theme-name" = "WhiteSur-Dark";
      "gtk-theme-name" = "adw-gtk3-dark";
      "gtk-icon-theme-name" = "WhiteSur-dark";
      "gtk-cursor-theme-name" = "Bibata-Modern-Ice";
    };
  };


  # QT
  qt = {
    enable = true;
    style = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
  };

  # Services that run as user services
  services.syncthing.enable = true;
}
