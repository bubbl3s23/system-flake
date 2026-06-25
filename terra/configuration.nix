{ pkgs, ... }: {
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "terra";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  time.timeZone = "America/Mazatlan";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  users.users."warp" = {
    isNormalUser = true;
    description = "warp";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ 
      librewolf
      calibre
      qbittorrent-enhanced
      alacritty
      emacs-gtk
      antigravity
      ungoogled-chromium
      amberol
      tauon
      chafa
      btop
      yazi
      devenv
    ];
  };

  environment.systemPackages = with pkgs; [
    # basic system packages
    vim
    wget
    git
    nssmdns
    fastfetch
    xdelta
    pciutils
    gzip
    #langs
    typescript
    gcc
    bun
    # fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.colored-man-pages
    fzf
    fishPlugins.grc
    grc
  ];

  programs.firefox.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      alias vim="nvim"
      alias add="git add ."
      alias commit="git commit -m"
      alias reload-ghostty="systemctl reload --user app-com.mitchellh.ghostty.service"
    '';
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  services.openssh.enable = true;
  virtualisation.docker.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.accept-flake-config = false;

  system.stateVersion = "26.05";
 }
