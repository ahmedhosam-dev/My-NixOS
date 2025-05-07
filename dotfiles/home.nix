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
  ];

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
    vscode-fhs
    postman
    figma-linux
    spotify
    
    # Utilities
    tree
    fzf
    grim slurp swappy
    libnotify
    gnome-system-monitor
    ripgrep
    breeze-icons
    kittysay
    fastfetch
    chafa
    nwg-look
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

    initExtra = ''
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

  # Services that run as user services
  services.syncthing.enable = true;
}
