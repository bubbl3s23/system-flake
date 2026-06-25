{ inputs, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  environment.systemPackages = with pkgs; [
    tree-sitter
    wl-clipboard-rs
    skim
    bat
    ripgrep
    fd
    delta
    jujutsu

    lua-language-server
    pyright
    astro-language-server
    nixfmt-rs
    nixd
  ];
}
