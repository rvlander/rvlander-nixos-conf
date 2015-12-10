# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      #configuration of the main environment
      ./modules/desktop.nix

      #configuring private stuff such as users
      ./private-modules
    ];

}
