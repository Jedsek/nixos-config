{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";
   
  home.username = "jedsek";
  home.homeDirectory = "/home/jedsek";

  programs.git = {
    enable = true;
    userName = "jedsek";
    userEmail = "jedsek@qq.com";
  };

  

  home.packages = with pkgs; [
    # terminal && editor
    ghostty
    zellij
    nushell
    fish
    helix
    zed
    zoxide
    yazi
    swww
    waybar
    swayosd
    swaynotificationcenter
    libnotify
    
    # wayland
    xwayland-satellite
    fuzzel
    slurp
    grim
    imv
    mpv
    wf-recorder

    # tools
    wget
    flatpak
    tailwindcss
    clash-meta
    wl-clipboard-rs
    stow
    unzip
    file
    ffmpeg
    imagemagick
    tokei
    dioxus-cli
    wasm-bindgen-cli
    zola
    pueue
    watchman
    ripgrep
    jq
    fzf
    skim
    tree
    sd
    bottom
    tlrc
    glow
    axel
    flatpak

    # language
    gcc
    clang

    # apps
    qq
    gnome-font-viewer
  ];

  programs.home-manager.enable = true;
}
