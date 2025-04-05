{ config, pkgs, ... }:
{
  home.username = "jedsek";
  home.homeDirectory = "/home/jedsek";
  home.stateVersion = "25.05";

  home.packages = [ pkgs.htop ];

  programs.home-manager.enable = true;
}
