{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      # Basic system fonts
      dejavu_fonts
      freefont_ttf
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      open-sans
      roboto

      # Developer fonts
      fira-code
      fira-code-symbols
      jetbrains-mono
      source-code-pro
      hack-font
      ubuntu_font_family
      dina-font
      proggyfonts
      fantasque-sans-mono
      iosevka
      cascadia-code
      # nerdfonts
      nerd-fonts.jetbrains-mono
      font-awesome

      # Additional useful fonts
      powerline-fonts
      material-icons
      material-design-icons
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "Fira Code"
          "JetBrains Mono"
          "Source Code Pro"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Open Sans"
          "DejaVu Sans"
          "Roboto"
        ];
        serif = [
          "DejaVu Serif"
          "Liberation Serif"
        ];
      };
    };
  };
}
