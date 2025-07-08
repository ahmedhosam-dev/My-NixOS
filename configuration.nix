{ config, lib, pkgs, ... }:

let
  username = "ahmed";
in {
  imports =
    [ 
      ./hardware-configuration.nix
      ./gpu-configuration.nix
      ./fonts.nix
      ./audio.nix
    ];

  ######################
  # BOOT CONFIGURATION #
  ######################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ################
  # AUTO UPGRADE #
  ################
  system.autoUpgrade.enable  = true;
  system.autoUpgrade.allowReboot  = true;

  ##############
  # NETWORKING #
  ##############
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  ##########
  # GREETD #
  ##########
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --asterisks \
          --time \
          --remember \
          --cmd "Hyprland"
        '';
        user = "greeter";
      };
    };
  };

  ############
  # KEYBOARD #
  ############
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "grp:win_space_toggle, caps:swapescape";
    };
  };
  
  ###############
  # FILE SYSTEM #
  ###############
  # Enable NTFS support
  boot.supportedFilesystems = [ "ntfs" ];

  # File systems configuration
  fileSystems = {
    "/mnt/W" = {
      device = "/dev/nvme0n1p3";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };
    "/mnt/S" = {
      device = "/dev/nvme0n1p4";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };
    "/mnt/C" = {
      device = "/dev/nvme0n1p5";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };
  };

  ################
  # LOCALIZATION #
  ################
  time.timeZone = "Africa/Cairo";

  ##########################
  # WINDOW MANAGER/DESKTOP #
  ##########################
  programs.hyprland.enable = true;

  ##############
  # ENABLE ZSH #
  ##############
  programs.zsh.enable = true;

  #########
  # Users #
  #########
  users.users."${username}" = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "wheel" "networkmanager" "input" "seat" "video" "audio" "docker" ];
    shell = pkgs.zsh;
  };
  home-manager.backupFileExtension = "backup-" + pkgs.lib.readFile "${pkgs.runCommand "timestamp" {} "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";

  ##############
  # VIRTUALBOX #
  ##############
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "${username}" "root" ];

  #########
  # INPUT #
  #########
  services.libinput = {
    enable = true;
    
    touchpad = {
      # Basic behavior
      naturalScrolling = true;
      tapping = true;
      tappingDragLock = true;
      disableWhileTyping = true;
      middleEmulation = true;
      scrollMethod = "twofinger";
      accelSpeed = "0.5";  # Adjust tracking speed (0 to 1)
      
      # Advanced options
      additionalOptions = ''
        # # Enable all gesture types
        # Option "GestureEnable" "true"
        # Option "CircularScrolling" "false"
        # Option "ScrollPixelDistance" "15"

        Option "Gesture" "true"
        Option "PinchGesture" "true"
        
        # Pinch gesture sensitivity
        Option "PinchSensitivity" "50"
        Option "PinchTransition" "50"
         
        # # Tap configuration
        # Option "Tapping" "on"
        # Option "TappingButtonMap" "lrm"
        # Option "TapAndDrag" "true"
        # Option "TapDragLock" "true"
        # 
        # # Palm rejection
        # Option "PalmDetection" "true"
        # Option "PalmMinWidth" "8"
        # Option "PalmMinZ" "100"
      '';
    };
  };

  ################
  # HOME MANAGER #
  ################
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = import ./home/${username}/main.nix;
  };

  ############
  # SECURITY #
  ############
  security = {
    doas = {
      enable = true;
      extraConfig = ''permit nopass ${username} as root'';
    };

    rtkit.enable = true;
  };

  ################
  # NIX SETTINGS #
  ################
  nix = {
    gc = {
      automatic = true;
      dates = "03:15";
      options = "--delete-older-than 30d";
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;

  ############
  # HARDWARE #
  ############
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  ############
  # SERVICES #
  ############
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
    dbus.enable = true;
    blueman.enable = true;
    power-profiles-daemon.enable = false;
    gnome.gnome-keyring.enable = true;
    wordpress.sites."localhost" = {};
  };

  virtualisation.docker.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk 
      xdg-desktop-portal-gnome
    ];
  };

  ###################
  # SYSTEM PACKAGES #
  ###################
  # nixpkgs.overlays = [ (import ./overrides.nix) ];
  environment.systemPackages = with pkgs; [
    # Core utilities
    git wget curl btop unzip gnumake libgcc
    gcc cmake tree fzf fd ripgrep lm_sensors

    # Development tools
    php84 php84Packages.composer
    nodejs_22
    python313 python312Packages.pip

    # R/W ntfs filesystem
    fuse ntfs3g gvfs

    # Desktop environment components 
    waybar rofi rofimoji kitty hyprpaper hyprlock pavucontrol
    wlogout jq gnused gnugrep coreutils libnotify
    pulseaudio libcanberra wireplumber rnnoise-plugin
    nvtopPackages.intel nvtopPackages.nvidia swaybg
    cliphist swayosd libinput 
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    # libappindicator-gtk3
    wayland-utils
    wl-clipboard
    

    # System tools 
    docker docker-compose ollama

    # KDE
    # kdePackages.kcalc
    # kdePackages.breeze
    # kdePackages.breeze-icons
    # kdePackages.qqc2-breeze-style

    # LSP Servers
    lua-language-server nixd lsp-ai marksman yaml-language-server
    vue-language-server typescript-language-server tailwindcss-language-server
    svelte-language-server vim-language-server cmake-language-server
    java-language-server dockerfile-language-server-nodejs 
    autotools-language-server
  ]; 

  #########
  # STEAM #
  #########
  programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  #########################
  # ENVIRONMENT VARIABLES #
  #########################
  environment = {
    variables = {
      EDITOR = "nvim";
      BROWSER = "brave";
      TERM = "kitty";
      XDG_CACHE_HOME = "$HOME/.cache";
    };

    sessionVariables = {
      LIBINPUT_DEFAULT_OPTIONS = "gesture:pinch:true";
      ADW_COLOR_SCHEME = "prefer-dark";
      NIXOS_OZONE_WL = "1";
      GTK_THEME = "WhiteSur-Dark";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      QT_QPA_PLATFORMTHEME = "gtk3";
      DISCORD_USE_X11="1 discord";
    };
  };

  ###########
  # SYSTEMD #
  ###########
  systemd.services.battery-threshold = {
    description = "Set battery charge threshold";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/bash -c 'echo 60 | tee /sys/class/power_supply/BAT0/charge_control_end_threshold'";
    };
  };

  #####################
  # MEMORY MANAGEMENT #
  #####################
  zramSwap = {
    enable = true;
    memoryPercent = 25;
    algorithm = "zstd";
  };

  ####################
  # POWER MANAGEMENT #
  ####################
  powerManagement.enable = true;
  services = {
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        # CPU settings (Intel-specific)
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
        
        # NVIDIA GPU power-saving
        NVIDIA_DYNAMIC_POWER_MANAGEMENT = "1"; # (0=off, 1=aggressive power-saving)
        
        # Disable Turbo Boost (reduces heat)
        CPU_BOOST_ON_AC = "0";
        CPU_BOOST_ON_BAT = "0";
        
        # PCIe power-saving (for Wi-Fi, USB, etc.)
        PCIE_ASPM_ON_BAT = "powersupersave";

        # Optional helps save long term battery health
        # START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
    };
  };

  ################################
  system.stateVersion = "24.11"; # Don't edit this line 
  ################################
}
