{ pkgs, ... }: {
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  networking.hostName = "terra";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  time.timeZone = "America/Mazatlan";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel"))
          return polkit.Result.YES;
      });
    '';
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
      ghostty
      emacs-gtk
      mpv
      antigravity
      ungoogled-chromium
      amberol
      tauon
      nautilus
      kdePackages.koko
      chafa
      gnome-text-editor
      gnome-feeds
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    btop
    nssmdns
    typescript
    gcc
    bun
    nixd
    pciutils
    fastfetch
    gpu-viewer
    mesa-demos
    bubblewrap
    fuse-overlayfs
    dwarfs
    xdelta

    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
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
