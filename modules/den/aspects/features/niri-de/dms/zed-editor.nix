{den, ...}: {
  den.aspects.niri-de.dms.zed-editor = {
    includes = [den.aspects.zed-editor];

    homeManager = {lib, ...}: {
      programs.zed-editor = {
        userSettings = {
          theme = lib.mkForce {
            light = "DankShell Light";
            dark = "DankShell Dark";
          };
        };
      };
    };
  };
}
