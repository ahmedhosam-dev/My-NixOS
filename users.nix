{ config, lib, pkgs, ... }:

{
  users.users.ahmed = {
    isNormalUser = true;
    home = "/home/ahmed";
    extraGroups = [ "wheel" "networkmanager" "input" "video" "audio" "docker" ];
    shell = pkgs.bash;
  };
}
