{ pkgs, ... }: {
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "terra";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  networking.firewall.allowedTCPPorts = [
    2234
  ];

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

  users.users."juno" = {
    isNormalUser = true;
    description = "juno";
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
      retroshare
      zathura
      keepassxc
      nicotine-plus
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
    nodejs
    python3
    postgresql
    # fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.colored-man-pages
    fishPlugins.grc
    fzf
    grc
  ];

  programs.firefox.enable = true;
  programs.fish = {
    enable = true;
    # shellInit = ''
    #   fish_vi_key_bindings
    # '';
    interactiveShellInit = ''
      set fish_greeting

      fish_vi_key_bindings
      set fish_vi_force_cursor 1

      alias vim="nvim"
      alias add="git add ."
      alias commit="git commit -m"
      alias reload-ghostty="systemctl reload --user app-com.mitchellh.ghostty.service"
      alias kill-emacs='emacsclient -e "(kill-emacs)"'

      fish_add_path -g "$HOME/.config/emacs/bin/"

      function fish_user_key_bindings
        # Complete with menu (shows list)
        # bind -M insert '\c@' complete

        # Complete without menu (in-line)
        # bind -M insert \e complete

        # Accept autosuggestion
        bind -M insert \cy accept-autosuggestion
        bind -M normal \cy accept-autosuggestion

        # Cycle through completion suggestions
        bind -M insert \cp up-or-search
        bind -M insert \cn down-or-search

        # Navigate in completion menu
        bind -M insert \cp up-or-search
        bind -M insert \cn down-or-search

        # Press tab to open menu, then j/k to navigate
        bind -M insert \ct tab-command

        # complete -c docker -n "__fish_seen_subcommand_from stop" -a "(docker ps -a --format '{{.Names}}')" -d "Container"
      end
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

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  virtualisation.docker.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.accept-flake-config = false;

  system.stateVersion = "26.05";
 }
