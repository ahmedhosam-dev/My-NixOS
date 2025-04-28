{ config, lib, pkgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ahmed = import ./home/ahmed/main.nix;
  };
}
