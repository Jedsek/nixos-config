{ config, pkgs, extra_config, ... }:

{
  home.stateVersion = "25.05";
  home.username = "${extra_config.user_name}";
  home.homeDirectory = "/home/${extra_config.user_name}";

  imports = [
    ./packages.nix
    ./terminal
    ./wayland
  ];

  programs.git = {
    enable = true;
    userName = "${extra_config.user_name}";
    userEmail = "${extra_config.user_email}";
  };

  programs.home-manager.enable = true;
}
