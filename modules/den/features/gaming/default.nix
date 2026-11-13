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
      directories = {
        "Games".enable = true;

        ".wine".enable = true;
        ".local/share/umu".enable = true;
        ".local/share/Steam/compatibilitytools.d".enable = true;
        ".config/pupgui".enable = true;
        ".config/MangoHud".enable = true;

        ".cache/umu".enable = true;
        ".cache/wine".enable = true;
        ".cache/winetricks".enable = true;
        ".cache/protontricks".enable = true;
        ".cache/mesa_shader_cache".enable = true;
        ".cache/mesa_shader_cache_db".enable = true;
      };
    };
  };
}
