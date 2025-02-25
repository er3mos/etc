{
  config,
  hostname,
  inputs,
  locale,
  pkgs,
  system,
  timezone,
  username,
  ...
}:

{
  imports = [./hardware-configuration.nix];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes and new cli. Git needs to be loaded before 
  # enabling flakes which is done at 'with pkgs;' below.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # deduplicates data to save storage space.
  nix.settings.auto-optimise-store = true;
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
  ];

  # global env vars set here
  # environment.variables = { 
  #   EDITOR = "nvim";
  # };

  # define main user account - TODO: make modular, user.nix?
  programs.fish.enable = true; # enable my main user shell
  users.users.sean = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;

    # Laptop Public Key
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBWPEWzFeIINdIlYzT742n6Mi0sM+HD/nTzrF+3Vyu5W" ];
    
    # usr packages
    packages = with pkgs; [
      firefox
      git
      vscodium
      vesktop
    ];
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "sean" = [ import ./../../home-manager/nixos/home.nix ];
    };
  };


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable OpenSSH daemon
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  # Set your time zone.
  time.timeZone = timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale;
    LC_IDENTIFICATION = locale;
    LC_MEASUREMENT = locale;
    LC_MONETARY = locale;
    LC_NAME = locale;
    LC_NUMERIC = locale;
    LC_PAPER = locale;
    LC_TELEPHONE = locale;
    LC_TIME = locale;
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "sean";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}