{ config, pkgs, lib, extra_config, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
