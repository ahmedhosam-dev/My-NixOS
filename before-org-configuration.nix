# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./gpu-configuration.nix

      ./fonts.nix


    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  
  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  programs.sway.enable = true;
  programs.hyprland.enable = true;
  

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     audio.enable = true;
     pulse.enable = true;
   };

  # Greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time";
        user = "greeter";
      };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.ahmed = {
     isNormalUser = true;
     home = "/home/ahmed";
     extraGroups = [ "wheel" "networkmanager" "input" "video" "audio" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
       code-cursor
       obsidian
       fzf
     ];
   };

  # doas
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass ahmed as root
    '';
  };

  # Automatic garbage collector
  nix.gc = {
    automatic = true;  # Enable the automatic garbage collector
    dates = "03:15";   # When to run the garbage collector
    options = "--delete-older-than 30d";  # Arguments to pass to nix-collect-garbage
  };

  # programs.firefox.enable = true;

  # Allow unfree pkgs
  nixpkgs.config.allowUnfree = true;

  # Blutooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     git
     wget
     curl
     neovim
     htop
     unzip
     waybar
     rofi
     dolphin
     kitty
     waybar
     hyprpaper
     pavucontrol
     brave
     (discord.override {
      withVencord = true;
    })
    gcc
    cmake
    php84 php84Packages.composer
    nodejs_22
    mysql84
    grim
    slurp
    swappy
    docker
    ollama
   ];

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;  # You can choose a different version if needed
  };

  # Allow flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow docker daemon
  virtualisation.docker = {
    enable = true;
  };

  programs.bash.shellAliases = {
    ll = "ls -la";
    u = "sudo nixos-rebuild switch --upgrade";
    cls = "clear";
    vim = "nvim";
    enc = "doas nvim /etc/nixos/configuration.nix";
  };

   # Zram
   zramSwap = {
   	enable = true;
	memoryPercent = 25;
	algorithm = "zstd";
   };



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}
