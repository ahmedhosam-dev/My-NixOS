{ pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = lib.fileContents ./init.lua;

    plugins = with pkgs.vimPlugins; [
      vim-nix

      # Color Scheme 
      tokyonight-nvim

      # Dashboard
      alpha-nvim
      plenary-nvim

      # Visual enhancements
      nvim-web-devicons
      lualine-nvim
      bufferline-nvim

      # Useful plugins
      telescope-nvim
      nvim-treesitter.withAllGrammars
      netrw-nvim nvim-web-devicons

      # Others
      presence-nvim autosave-nvim

      # For coding
      nvim-autopairs toggleterm-nvim
    ];
  };
}
