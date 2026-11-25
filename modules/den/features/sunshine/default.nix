{
  den.aspects.sunshine = {
    nixos = {
      services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
      };

      hardware = {
        uinput.enable = true;
      };
    };

    user = {
      extraGroups = [
        "video"
        "render"
        "uinput"
      ];
    };

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.sunshine];
    };

    persist-user = {
      directories = {
        ".config/sunshine".enable = true;
      };
    };
  };
}
