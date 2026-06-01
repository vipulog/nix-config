{den, ...}: {
  den.aspects.niri = {
    includes = [den.aspects.alacritty];

    nixos = {
      services.displayManager.gdm = {
        enable = true;
      };

      programs.dms-shell = {
        enable = true;
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

      programs.niri = {
        enable = true;
      };
    };

    homeManager = {
      lib,
      pkgs,
      ...
    }: {
      home.packages = [pkgs.xwayland-satellite];

      programs.alacritty = {
        settings = {
          general."import" = [
            "~/.config/alacritty/dank-theme.toml"
          ];

          window = {
            decorations = "None";
            opacity = 0.9;
          };
        };
      };

      home.activation.setupDms = let
        settingsJson = ./config/DankMaterialShell/settings.json;
        clSettingsJson = ./config/DankMaterialShell/clsettings.json;
        alacrittyTheme = ./config/alacritty/dank-theme.toml;
        niriDirNix = ./config/niri;
      in
        lib.hm.dag.entryAfter ["writeBoundary"]
        # sh
        ''
          configHome="''${XDG_CONFIG_HOME:-$HOME/.config}"

          configDir="$configHome/DankMaterialShell"
          alacrittyDir="$configHome/alacritty"
          niriDir="$configHome/niri"

          mkdir -p \
            "$configDir" \
            "$alacrittyDir" \
            "$niriDir"

          copy_if_missing() {
            src="$1"
            dest="$2"

            if [ ! -e "$dest" ]; then
              install -Dm644 "$src" "$dest"
            fi
          }

          copy_if_missing \
            ${settingsJson} \
            "$configDir/settings.json"

          copy_if_missing \
            ${clSettingsJson} \
            "$configDir/clsettings.json"

          copy_if_missing \
            ${alacrittyTheme} \
            "$alacrittyDir/dank-theme.toml"

          # Copy all files from ./config/niri recursively if missing
          while IFS= read -r -d ''' file; do
            rel="''${file#${niriDirNix}/}"
            copy_if_missing "$file" "$niriDir/$rel"
          done < <(find ${niriDirNix} -type f -print0)
        '';
    };
  };
}
