{ config, pkgs, lib, extra_config, inputs, ... }:

{ 
  home.file.".config/alacritty" = {
    enable = true;
    force = true;
    recursive = true; 
    source = ./alacritty;
  };

  home.file.".config/atuin" = {
    enable = true;
    force = true;
    recursive = true; 
    source = ./atuin;
  };

  home.file.".config/fastfetch" = {
    enable = true;
    force = true;
    recursive = true;
    source = ./fastfetch;
  };

  home.file.".config/ghostty" = {
    enable = true;
    force = true;
    recursive = true;
    source = ./ghostty;
  };

  home.file.".config/helix" = {
    enable = true;
    force = true;
    recursive = true;
    source = ./helix;
  };

  home.file.".config/ion" = {
    enable = true;
    force = true;
    recursive = true;
    source = ./ion;
  };

  home.file.".config/kitty" = {
    enable = true;
    force = true;
    recursive = true;
    source = ./kitty;
  };

  home.file.".config/nushell" = {
    enable = true;
    force = true;
    recursive = true;
    source = ./nushell;
  };

  home.file.".config/wezterm" = {
    enable = true;
    force = true;
    recursive = true;
    source = ./wezterm;
  };

  home.file.".config/yazi" = {
    enable = true;
    force = true;
    recursive = true;
    source = ./zellij;
  };
}

