{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./gpu-configuration.nix
      ./fonts.nix
      ./users.nix
      # ./home-manager.nix
      # ./audio.nix
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
  
  ################
  # LOCALIZATION #
  ################
  time.timeZone = "Africa/Cairo";

  ##########################
  # WINDOW MANAGER/DESKTOP #
  ##########################
  programs.sway.enable = true;
  programs.hyprland.enable = true;
  

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
  # INPUT #
  #########
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = false;
      tapping = true;
      clickMethod = "clickfinger";
      scrollMethod = "two-finger";
      middleEmulation = true;
      disableWhileTyping = true;
      accelSpeed = "0.5";
    };
  };

  systemd.user.services.touchegg = {
    enable = true;
    description = "Touchégg";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.touchegg}/bin/touchegg";
      Restart = "on-failure";
    };
  };

  ################
  # HOME MANAGER #
  ################
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ahmed = import ./home/ahmed/main.nix;
  };

  ############
  # SECURITY #
  ############
  security = {
    doas = {
      enable = true;
      extraConfig = ''permit nopass ahmed as root'';
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

  ###########
  # FLATPAK #
  ###########
  services.flatpak.enable = true;

  ############
  # HARDWARE #
  ############
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  ###################
  # SYSTEM PACKAGES #
  ###################
  environment.systemPackages = with pkgs; [
    # Core utilities
    git wget curl btop unzip gnumake

    # Desktop environment components 
    waybar rofi rofimoji dolphin kitty hyprpaper pavucontrol
    wlogout jq gnused gnugrep coreutils libnotify
    pulseaudio libcanberra wireplumber rnnoise-plugin
    nvtopPackages.intel nvtopPackages.nvidia
    touchegg bottles cliphist

    # System tools 
    docker docker-compose ollama
  ];

  #########################
  # ENVIRONMENT VARIABLES #
  #########################
  environment.variables = {
    EDITOR = "nvim";
  };

  ############
  # SERVICES #
  ############
  services.dbus.enable = true;
  xdg.portal.enable = true;

  virtualisation.docker.enable = true;

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
