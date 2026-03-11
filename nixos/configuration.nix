{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.systemd-boot.configurationLimit = 2;

  # Auto garbage collect old generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Plymouth boot splash
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";

  # Hibernate support
  boot.resumeDevice = "/dev/disk/by-label/swap";

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone & Locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  hardware.graphics.enable = true;

  # Display & Desktop
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Keyd (capslock -> backspace)
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "backspace";
      };
    };
  };

  # Docker
  virtualisation.docker.enable = true;

  # Steam + Gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  hardware.graphics.enable32Bit = true;

  # ZSH + Oh My Zsh
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        "fzf"
        "docker"
        "sudo"
        "colored-man-pages"
        "command-not-found"
      ];
    };
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # User
  users.users.lakshin = {
    isNormalUser = true;
    description = "lakshin";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Browsers
  programs.firefox.enable = true;

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    # Editors & IDEs
    vim
    vscode
    jetbrains.idea-oss

    # CLI tools
    git
    curl
    wget
    fastfetch
    bat
    fzf
    ripgrep
    eza
    fd
    zoxide
    lazydocker
    lazygit
    htop
    btop
    tldr
    unzip
    tree
    jq
    yq
    duf
    dust
    procs

    # Browsers
    vivaldi
    google-chrome

    # Terminal
    ghostty

    # System
    efibootmgr

    # Shell
    zsh
    zsh-powerlevel10k

    # Dev
    docker-compose
    nodejs
    python3
  ];

  # Powerlevel10k
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.promptInit = ''
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
  '';

  # Aliases
  environment.shellAliases = {
    ls = "eza --icons";
    ll = "eza -la --icons";
    lt = "eza --tree --icons";
    la = "eza -a --icons";
    cat = "bat";
    find = "fd";
    top = "btop";
    lg = "lazygit";
    ld = "lazydocker";
    nrs = "cd ~/repos/github.com/Lakshin01/dotfiles/nixos && sudo nixos-rebuild switch --flake .#nixos";
  };

  system.stateVersion = "25.11";
}
