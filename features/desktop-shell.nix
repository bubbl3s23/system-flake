{ pkgs, inputs, config, ... }: {
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
    ripgrep
    fd
    nemo
    ddcutil

    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.jetbrains-mono
    nerd-fonts.lekton
    nerd-fonts.mononoki
  ];

  programs.niri.enable = true;

  # services.gnome.gnome-keyring.enable = true;

  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  systemd.user.services.niri.enableDefaultPath = false;

 # services.greetd = {
 #  enable = true;
 #  settings = {
 #    default_session = {
 #      command = "${config.programs.niri.package}/bin/niri-session";
 #      user = "warp";
 #    };
 #  };
 # };
}
