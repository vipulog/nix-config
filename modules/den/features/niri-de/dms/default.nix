{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    dms = {
      url = "github:duxlabs-dev/dux-shell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri-de.dms = let
    commonDmsConfig = {pkgs, ...}: {
      programs.dank-material-shell = {
        enable = true;
        package = pkgs.dux-shell;
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

    mkCommonDmsPackages = pkgs: [
      pkgs.dux-gop
      pkgs.qt6.qtimageformats
      pkgs.kdePackages.kimageformats
      pkgs.adw-gtk3
      pkgs.wtype
    ];
  in {
    includes = with den.aspects.niri-de.dms; [
      greeter
      settings
      dsearch
      plugins
      niri
      alacritty
      zed-editor
    ];

    nixos = {pkgs, ...}: {
      imports = [
        inputs.dms.nixosModules.dank-material-shell
        commonDmsConfig
      ];

      services.upower.enable = true;
      environment.systemPackages = mkCommonDmsPackages pkgs;
    };

    homeManager = {pkgs, ...}: {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        commonDmsConfig
      ];

      home.packages = mkCommonDmsPackages pkgs;
    };

    persist-user = {
      directories = [
        ".config/dms"
        ".local/state/dms"
        ".cache/dms"
      ];
    };
  };
}
