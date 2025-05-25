{ pkgs, lib, ... }:

let
  SIGMazer-presence-nvim= pkgs.vimPlugins.presence-nvim.overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner = "SIGMazer";
      repo = "presence.nvim";
      rev = "feature/CustomImage";
      sha256 = "sha256-dUZSNQhYMwgsXnTBbEapyfI101OH5bxGTCnPMAdBxLQ=";
    };
  });
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraLuaConfig = lib.fileContents ./init.lua;

    plugins = with pkgs.vimPlugins; [
      vim-nix

      # Color Scheme 
      tokyonight-nvim

      # Dashboard
      alpha-nvim
      plenary-nvim

      # Visual enhancements
      nvim-web-devicons mini-icons
      lualine-nvim
      bufferline-nvim
      indent-blankline-nvim

      # Useful plugins
      telescope-nvim telescope-fzf-native-nvim
      nvim-treesitter.withAllGrammars
      gitsigns-nvim nvim-tree-lua
      which-key-nvim

      # For coding
      nvim-autopairs toggleterm-nvim comment-nvim

      # LSP&CMP
      nvim-lspconfig cmp-nvim-lsp nvim-cmp
      cmp-buffer cmp-path cmp-cmdline 
      cmp-vsnip vim-vsnip vim-vsnip-integ

      # Others
      SIGMazer-presence-nvim autosave-nvim
    ];
  };
}
