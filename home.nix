{ config, pkgs, extra_config, ... }:

{
  home.stateVersion = "25.05";
  home.username = "${extra_config.user_name}";
  home.homeDirectory = "/home/${extra_config.user_name}";

  programs.git = {
    enable = true;
    userName = "${extra_config.user_name}";
    userEmail = "${extra_config.user_email}";
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

    # apps
    qq
    gnome-font-viewer
  ];

  programs.home-manager.enable = true;
}
