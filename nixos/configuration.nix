{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Johannesburg";
  i18n.defaultLocale = "en_GB.UTF-8";
  hardware.graphics.enable = true; 
  programs.hyprland.enable=true;
  programs.zsh.enable = true; 
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true;

  nixpkgs.config.allowUnfree = true;
	

  systemd.services.cpupower = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };

  powerManagement.cpuFreqGovernor = "performance"; 
  #services.thermald.enable = true;
  
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
  };
  
  users.extraGroups.vboxusers.members = [ "lithium" ];
  virtualisation.virtualbox.host.enable = true;

  users.users.lithium = {
    isNormalUser = true;
    description = "Lithium";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kitty
      neovim
      #steam
      swww
      yarn
      jruby 
      ruby
      pnpm 
      socat
      flatpak
      jekyll
      lolcat
      jq
      wofi   
      acpi
      firefox
      bluez
      ninja
      meson
      nodejs
      python3Packages.pygobject3
      libadwaita
      catppuccin-gtk
      rofi-wayland
      mplayer
      wirelesstools
      linuxHeaders
      brave
      tor
      pulseaudio
      playerctl
      mpc
      qt5.qttools
      qt5.qtbase
      procps
      gcc
      gnumake
      wpa_supplicant
      nwg-look
      xbindkeys
      python3Packages.pygobject3
      cmake
      git
      opencv
      mesa
      mesa.drivers
      libglvnd
      glibc
      #virtualbox
      gradience
      gtk3
      pavucontrol
      eww
      nautilus
      alsa-utils
      swayimg
      waybar
      lutris
      flatpak
      brightnessctl
      hyprlock 
      wlogout
      gparted
      grim
      gnome-software
      gnome-tweaks
      jq
      htop
      lm_sensors
      git
      curl
      wget
      man
      nmap
      wofi
      python3
      python3Full
      python3Packages.pip
      glib
      unrar
      python3Packages.virtualenv
      neofetch

    ];
  };
 
  fonts.packages = with pkgs; [ nerdfonts ];
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  networking.firewall.allowedTCPPorts = [ 443 80 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.enable = true;
  networking.firewall.extraCommands = ''
	iptables -A INPUT -s 10.0.0.105 -j ACCEPT
	iptables -A INPUT -p tcp --dport 22 -s 10.0.0.105 -j ACCEPT
	iptables -A INPUT -p tcp --dport 22 -j DROP  
  '';

  environment.systemPackages = with pkgs; [
    #sys packages
    gtk4
    swaynotificationcenter
    pkg-config
    pango 
  ];

  system.stateVersion = "24.11"; 

}
