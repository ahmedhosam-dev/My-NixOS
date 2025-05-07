{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "FantasqueSansM Nerd Font Mono Bold";
      size = 16;
    };

    extraConfig = ''
      include Tokyo-Night.conf
    '';

    settings = {
      # Font settings
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      
      # Window/behavior settings
      background_opacity = "0.9";
      dynamic_background_opacity = "1";
      confirm_os_window_close = "0";
      linux_display_server = "auto";
      scrollback_lines = "2000";
      wheel_scroll_min_lines = "1";
      enable_audio_bell = "no";
      window_padding_width = "4";
      selection_foreground = "#FFFFFF";
      selection_background = "#3F37C9";
      
      # # Color scheme - UX optimized
      # foreground = "#E2E2E2";  # Light gray for better contrast
      # background = "#120E1A";  # Dark purple-black (derived from your palette)
      # cursor = "#4CC9F0";     # Bright cyan cursor for visibility
      # 
      # # Tab colors
      # active_tab_foreground = "#120E1A";
      # active_tab_background = "#4CC9F0";
      # inactive_tab_foreground = "#B0B0B0";
      # inactive_tab_background = "#1E1A2B";
      # 
      # # Border colors
      # active_border_color = "#4CC9F0";
      # inactive_border_color = "#3A0CA3";
      # bell_border_color = "#F72585";
      # 
      # # Extended color palette (UX optimized)
      # color0 = "#1E1A2B";     # Dark purple
      # color1 = "#F72585";     # Vibrant pink (error)
      # color2 = "#4895EF";     # Soft blue (success)
      # color3 = "#4CC9F0";     # Cyan (warning)
      # color4 = "#3F37C9";     # Purple (info)
      # color5 = "#B5179E";     # Magenta
      # color6 = "#4361EE";     # Bright blue
      # color7 = "#E2E2E2";     # Light gray (foreground)
      # color8 = "#2A2540";     # Darker purple
      # color9 = "#FF3D96";     # Brighter pink (error accent)
      # color10 = "#5CA8FF";    # Lighter blue (success accent)
      # color11 = "#6AE6FF";    # Bright cyan (warning accent)
      # color12 = "#5A52E0";    # Light purple (info accent)
      # color13 = "#D126C0";    # Bright magenta
      # color14 = "#5D7DFF";    # Light blue
      # color15 = "#FFFFFF";    # Pure white (bold text)
    };
  };

}
