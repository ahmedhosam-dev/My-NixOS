{ config, pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.username = "ahmed";
  home.homeDirectory = "/home/ahmed";
  home.stateVersion = "24.11";

  # User packages
  home.packages = with pkgs; [
    # Development tools
    gcc
    cmake
    php84 php84Packages.composer
    nodejs_22
    mysql84
    
    # Applications
    brave
    (discord.override { withVencord = true; })
    obsidian
    code-cursor
    figma-linux
    spotify
    
    # Utilities
    tree
    fzf
    grim slurp swappy
    libnotify
    gnome-system-monitor
    ripgrep
    starship
  ];

  # Import Configruations files
  imports = [
    ./hyprland/main.nix
    ./touchegg.nix
    ./neovim/main.nix
    ./kitty.nix
    # ./starship.nix
  ];

  # Notification
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        origin = "top-right";
        offset = "10x50";
        transparency = 10;
        frame_color = "#aaaaaa";
        font = "Fira Code 10";
        icon_path = "${config.home.homeDirectory}/.config/swaync/images/";
      };
    };
  };

  # Shell configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      gen = "sudo nixos-rebuild switch";
      u = "$(gen) --upgrade";
      cls = "clear";
      vim = "nvim";
      enc = "doas nvim /etc/nixos/";
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

  # Starship
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;
      format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
      character = {
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
    };
  };

  # Services that run as user services
  services.syncthing.enable = true;
}
