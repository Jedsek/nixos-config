{ config, pkgs, extra_config, ... }:

{
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
    cava
    
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
    tailwindcss_4
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
    fastfetch
    flatpak

    # language
    gcc
    nodejs

    # apps
    qq
    gnome-font-viewer
  ];
}
