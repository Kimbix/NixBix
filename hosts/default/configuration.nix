# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
		../../modules/nixos/sound/pipewire.nix
		../../modules/nixos/shells/zsh.nix
		../../modules/nixos/fonts.nix
		./hardware-configuration.nix
		inputs.home-manager.nixosModules.default
	];

	programs.hyprland.enable = true;
	programs.dconf.enable = true;

	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
	};


	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
		extraPackages = with pkgs; [
      amdvlk
      vaapiVdpau # not sure if this is needed
      libvdpau-va-gl # also not sure if this is needed
      rocmPackages.clr.icd
		];
		extraPackages32 = with pkgs; [
			driversi686Linux.amdvlk
		];
	};
	services.xserver.videoDrivers = [ "amdgpu" ]; # this also enables them for wayland lmao

	hardware.pulseaudio.enable = false;
	services.xserver = {
		enable = true;
		desktopManager.gnome.enable = true;
	};

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "HumbertoPC";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Caracas";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_US.UTF-8";
    LC_IDENTIFICATION = "es_US.UTF-8";
    LC_MEASUREMENT = "es_US.UTF-8";
    LC_MONETARY = "es_US.UTF-8";
    LC_NAME = "es_US.UTF-8";
    LC_NUMERIC = "es_US.UTF-8";
    LC_PAPER = "es_US.UTF-8";
    LC_TELEPHONE = "es_US.UTF-8";
    LC_TIME = "es_US.UTF-8";
  };

  # Configure keymap in X11
	services.xserver.xkb.layout = "us";
	services.xserver.xkb.variant = "";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.humberto = {
    isNormalUser = true;
    description = "Humberto Aleman";
    extraGroups = [ "networkmanager" "wheel" ];

		shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "humberto" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
		git
		rustup
		gcc
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

	programs.steam.enable = true;
}
