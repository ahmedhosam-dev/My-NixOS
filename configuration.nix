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

  ##############
  # NETWORKING #
  ##############
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
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

  #################
  # LOGIN MANAGER #
  #################
  services.greetd = {
    enable = true;
    settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time";
        user = "greeter";
    };
  };

  #########
  # Users #
  #########
  users.users."${username}" = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "wheel" "networkmanager" "input" "seat" "video" "audio" "docker" ];
    shell = pkgs.zsh;
  };

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
    tlp = {
      enable = true;
      settings = {
        # CPU settings (Intel-specific)
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_MAX_PERF_ON_AC = 90;
        CPU_MAX_PERF_ON_BAT = 70;
        
        # NVIDIA GPU power-saving
        NVIDIA_DYNAMIC_POWER_MANAGEMENT = "1"; # (0=off, 1=aggressive power-saving)
        
        # Disable Turbo Boost (reduces heat)
        CPU_BOOST_ON_AC = "0";
        CPU_BOOST_ON_BAT = "0";
        
        # PCIe power-saving (for Wi-Fi, USB, etc.)
        PCIE_ASPM_ON_BAT = "powersupersave";
      };
    };
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
  };

  virtualisation.docker.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  ###################
  # SYSTEM PACKAGES #
  ###################
  environment.systemPackages = with pkgs; [
    # Core utilities
    git wget curl btop unzip gnumake

    # R/W ntfs filesystem
    fuse ntfs3g

    # Desktop environment components 
    waybar rofi rofimoji kitty hyprpaper pavucontrol
    wlogout jq gnused gnugrep coreutils libnotify
    pulseaudio libcanberra wireplumber rnnoise-plugin
    nvtopPackages.intel nvtopPackages.nvidia swaybg
    cliphist swayosd libinput 

    # System tools 
    docker docker-compose ollama

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
  # services.getty.autologinUser = "ahmed";
  # environment = {
  #   loginShellInit = ''
  #     [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
  #   '';
  # };

  #########################
  # ENVIRONMENT VARIABLES #
  #########################
  environment = {
    variables = {
      EDITOR = "nvim";
      BROWSER = "brave";
      TERM = "kitty";
    };

    sessionVariables = {
      LIBINPUT_DEFAULT_OPTIONS = "gesture:pinch:true";
      ADW_COLOR_SCHEME = "prefer-dark";
      NIXOS_OZONE_WL = "1";
      GTK_THEME = "WhiteSur-Dark";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XDG_CURRENT_DESKTOP = "Hyprland";
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

  ################################
  system.stateVersion = "24.11"; # Don't edit this line 
  ################################
}
