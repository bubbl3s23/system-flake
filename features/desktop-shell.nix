{ pkgs, inputs, ... }: {
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
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

  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  systemd.user.services.niri.enableDefaultPath = false;

  programs.noctalia-greeter = {
    enable = true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

    settings.cursor = {
      theme = "Adwaita";
      size = 24;
      package = pkgs.adwaita-icon-theme;
    };
  };
}
