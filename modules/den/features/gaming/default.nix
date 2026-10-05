{
  den.aspects.gaming = {
    nixos = {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      programs.gamemode.enable = true;
    };

    user = {
      extraGroups = ["gamemode"];
    };

    persist-user = {
      directories = [
        "Games"
      ];
    };
  };
}
