{ pkgs, ... }: {
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    protonup-qt
    (retroarch.override {
      cores = with libretro; [
        swanstation     # PS1 - modern
        beetle-psx-hw   # PS1 - accurate
        snes9x          # SNES
        mgba            # GBA
        genesis-plus-gx # Genesis
      ];
    })
  ];
}
