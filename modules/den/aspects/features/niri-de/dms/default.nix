{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri-de.dms = {user}: {
    includes = with den.aspects.niri-de.dms; [
      settings
      niri
      alacritty
    ];

    nixos = {pkgs, ...}: {
      imports = [inputs.dms.nixosModules.dank-material-shell];

      services.upower.enable = true;

      programs.dank-material-shell = {
        enable = true;
        package = pkgs.dms-shell;
        quickshell.package = pkgs.quickshell;

        enableVPN = true;
        enableCalendarEvents = true;
        enableClipboardPaste = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableSystemMonitoring = true;

        systemd = {
          enable = true;
          restartIfChanged = true;
        };
      };
    };

    homeManager = {pkgs, ...}: {
      imports = [inputs.dms.homeModules.dank-material-shell];

      home.packages = [
        pkgs.dgop
      ];

      programs.dank-material-shell = {
        enable = true;
        package = pkgs.dms-shell;
        quickshell.package = pkgs.quickshell;
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".config/DankMaterialShell"
        ".local/state/DankMaterialShell"
        ".cache/DankMaterialShell"
        ".cache/quickshell"
        ".local/share/color-schemes"
      ];
    };
  };
}
