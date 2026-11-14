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
    sharedModule = {pkgs, ...}: {
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

    mkCommonPkgs = pkgs: [
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
        sharedModule
      ];

      services.upower.enable = true;
      environment.systemPackages = mkCommonPkgs pkgs;
    };

    homeManager = {pkgs, ...}: {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        sharedModule
      ];

      home.packages = mkCommonPkgs pkgs;
    };

    persist-user = {
      directories = {
        ".config/dms".enable = true;
        ".local/state/dms".enable = true;
        ".cache/dms".enable = true;
      };
    };
  };
}
