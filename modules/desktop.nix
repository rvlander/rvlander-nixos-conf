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
    blender
    apg

    firefoxWrapper
    chromium
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
    gnome3.gnome_settings_daemon
    networkmanagerapplet
    arandr
    pidgin

    nodejs
    nodePackages.nodemon
    nodePackages.mocha
    nodePackages.gulp

    pgadmin
    postgresql94

    htop
    gparted
    evince
    gimp

    bash
    duplicity
    xautolock
    xorg.xbacklight

    matter-compiler

    sshuttle

    pavucontrol
    python2

    cargo
    rustc
    racerRust

    steam
    libreoffice

    bundler
    bundix
    unzip

    cmakeWithGui
  ];

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  services.xserver.displayManager.sessionCommands = "${pkgs.networkmanagerapplet}/bin/nmapplet &";

  programs.zsh.enable = true;
  programs.bash.enableCompletion = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # Enable the X11 windowing system
  # services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.enable = true;
  services.xserver.layout = "fr";
  services.xserver.xkbVariant = "oss";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  #does not work
  services.xserver.synaptics.palmDetect = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  services.teamviewer.enable = true;

  services.xserver.windowManager.i3.enable = true;
  environment.etc."i3status.conf".source = ./i3status.conf;
  environment.etc."i3/config".source = ./i3.config;

  # System wide zsh
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  services.virtualboxHost.enable = true;
  services.virtualboxHost.addNetworkInterface = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "unstable";


  # Configure synergy
  # services.synergy.client.enable = true;
  # services.synergy.client.screenName = "TOTO";
  # services.synergy.client.serverAddress = "192.168.95.101";

  #auto update
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;


  #screen hot plug with i3
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", RUN+="${./monitor-hotplug.sh}"
  '';

  # sudo
  security.sudo.enable = true;

  services.xserver.vaapiDrivers = [ pkgs.vaapiIntel ];

  nixpkgs = {
    config = {
      /*packageOverrides = pkgs:
      let
        bundlerGem = { buildRubyGem, makeWrapper, ruby, coreutils }:
        buildRubyGem {
          name = "bundler-1.9.10";
          namePrefix = "";
          sha256 = "0ygpfvk51x96a8r3jknx7vf6afabxqp8byayvkka3rqkwv0jssqs";
          dontPatchShebangs = true;
          postInstall = ''
          find $out -type f -perm -0100 | while read f; do
            substituteInPlace $f \
              --replace "/usr/bin/env" "${coreutils}/bin/env"
          done

              wrapProgram $out/bin/bundler \
              --prefix PATH ":" ${ruby}/bin
              '';
            };
            in
            rec {
              bundlerEnv = pkgs.bundlerEnv.override {
                bundler_HEAD = bundlerGem {
                  buildRubyGem = pkgs.buildRubyGem;
                  makeWrapper = pkgs.makeWrapper;
                  ruby = pkgs.ruby;
                  coreutils = pkgs.coreutils;
                };
              };
            };*/
      git = {
        svnSupport = true;
      };
      allowUnfree = true;
      firefox = {
        enableGoogleTalkPlugin = true;
      };

      chromium = {
        enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works
        enablePepperPDF = true;
      };
    };
  };
}
