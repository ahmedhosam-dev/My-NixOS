# This file defines custom package overrides.
# Usage: Add `nixpkgs.overlays = [ (import ./overrides.nix) ];` in configuration.nix.

self: super: {

  # Waybar (master branch)
  waybar = super.waybar.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "Alexays";
      repo = "Waybar";
      rev = "master";
      sha256 = "sha256-29g4SN3Yr4q7zxYS3dU48i634jVsXHBwUUeALPAHZGM=";
    };
    # Optional: Enable experimental features
    mesonFlags = (old.mesonFlags or []) ++ [ 
      "-Dexperimental=true"
      "-Dcava=disabled"
    ];
  });

  # Add other package overrides here...
  # Example: Neovim (unstable)
  # neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: {
  #   src = super.fetchFromGitHub {
  #     owner = "neovim";
  #     repo = "neovim";
  #     rev = "master";
  #     sha256 = "000...000";
  #   };
  # });

}
