{ config, pkgs, ... }:

{
  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr";
    defaultLocale = "fr_FR.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    vim

    git
    atom

    firefoxWrapper
    thunderbird
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle

    i3status
    dmenu
    i3lock

    chefdk
    vagrant

    gnome3.dconf
    networkmanagerapplet
    arandr
    pidgin

    nodejs
    nodePackages.nodemon
    nodePackages.mocha

    pgadmin
    postgresql94

    htop
    gparted
    evince

    bash
    duplicity
  ];

  services.xserver.displayManager.sessionCommands = "${pkgs.networkmanagerapplet}/bin/nmapplet &";

  programs.zsh.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # Enable the X11 windowing system
  # services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.enable = true;
  services.xserver.layout = "fr";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.configFile = ./i3.config;
  environment.etc."i3status.conf".source = ./i3status.conf;

  # System wide zsh
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  services.virtualboxHost.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "unstable";


  # Configure synergy
  # services.synergy.client.enable = true;
  # services.synergy.client.screenName = "TOTO";
  # services.synergy.client.serverAddress = "192.168.95.101";

  #auto update
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;


  # sudo
  security.sudo.enable = true;

}
