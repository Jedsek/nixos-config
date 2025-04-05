{ config, pkgs, lib, extra_config, inputs, ... }:

{
  home.file.".config/fuzzel" = {
    enable = true;
    force = true;
    recursive = true; 
    source = ./fuzzel;
  };

  # home.file.".config/hypr" = {
  #   enable = true;
  #   force = true;
  #   recursive = true; 
  #   source = ./hypr;
  # };

  # home.file.".config/mako" = {
  #   enable = true;
  #   force = true;
  #   recursive = true; 
  #   source = ./mako;
  # };

  # home.file.".config/niri" = {
  #   enable = true;
  #   force = true;
  #   recursive = true; 
  #   source = ./niri;
  # };

  # home.file.".config/swaylock" = {
  #   enable = true;
  #   force = true;
  #   recursive = true; 
  #   source = ./swaylock;
  # };

  # home.file.".config/swaync" = {
  #   enable = true;
  #   force = true;
  #   recursive = true; 
  #   source = ./swaync;
  # };

  # home.file.".config/swayosd" = {
  #   enable = true;
  #   force = true;
  #   recursive = true; 
  #   source = ./swayosd;
  # };

  # home.file.".config/waybar" = {
  #   enable = true;
  #   force = true;
  #   recursive = true; 
  #   source = ./waybar;
  # };

  # home.file.".config/wob" = {
  #   enable = true;
  #   force = true;
  #   recursive = true; 
  #   source = ./wob;
  # };

  # home.file.".config/wofi" = {
  #   enable = true;
  #   force = true;
  #   recursive = true; 
  #   source = ./wofi;
  # };
}
