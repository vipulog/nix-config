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

    persist-user = {
      directories = [
        ".config/sunshine"
      ];
    };
  };
}
