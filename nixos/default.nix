{ config, pkgs, lib, inputs, extra_config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
