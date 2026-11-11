{lib, ...}: {
  den.aspects.gaming = let
    mkCommonPkgs = pkgs: [
      pkgs.gamemode
      pkgs.gamescope
      pkgs.wineWow64Packages.stable
      pkgs.mangohud
      pkgs.winetricks
      pkgs.umu-launcher
      pkgs.protonup-qt
      pkgs.protontricks
    ];
  in {
    nixos = {pkgs, ...}: {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      programs.gamemode = {
        enable = true;
        enableRenice = true;
      };

      programs.gamescope = {
        enable = true;
        capSysNice = true;
      };

      environment = {
        systemPackages = mkCommonPkgs pkgs;

        sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS =
          lib.mkDefault "${pkgs.proton-ge-bin.steamcompattool}";
      };
    };

    homeManager = {pkgs, ...}: {
      home = {
        packages = mkCommonPkgs pkgs;

        sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS =
          lib.mkDefault "${pkgs.proton-ge-bin.steamcompattool}";
      };
    };

    user = {
      extraGroups = [
        "video"
        "render"
        "gamemode"
      ];
    };

    persist-user = {
      directories = [
        "Games"

        ".wine"
        ".local/share/umu"
        ".local/share/Steam/compatibilitytools.d"
        ".config/pupgui"
        ".config/MangoHud"

        ".cache/umu"
        ".cache/wine"
        ".cache/winetricks"
        ".cache/protontricks"
        ".cache/mesa_shader_cache"
        ".cache/mesa_shader_cache_db"
      ];
    };
  };
}
