{den, ...}: {
  den.aspects.niri-de.dms.niri = {
    includes = [den.aspects.niri-de.dms.niri.binds];

    homeManager = {lib, ...}:
      with den.aspects.niri-de.dms.niri; let
        dynamicFiles = [
          "alttab.kdl"
          "colors.kdl"
          "cursor.kdl"
          "input.kdl"
          "layout.kdl"
          "outputs.kdl"
          "windowrules.kdl"
          "wpblur.kdl"
        ];
      in {
        wayland.windowManager.niri.extraConfig = ''
          include "dms/alttab.kdl"
          include "dms/binds.kdl"
          include "dms/colors.kdl"
          include "dms/cursor.kdl"
          include "dms/layout.kdl"
          include "dms/outputs.kdl"
          include "dms/windowrules.kdl"
          include "dms/wpblur.kdl"
          include "dms/input.kdl"
        '';

        home.activation.dmsNiriConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
          dms_dir="$HOME/.config/niri/dms"
          mkdir -p "$dms_dir"

          for file in ${lib.concatStringsSep " " dynamicFiles}; do
            [ -f "$dms_dir/$file" ] || touch "$dms_dir/$file"
          done

          cat > "$dms_dir/binds.kdl" <<'EOF'
          ${binds.configKdl}
          EOF
        '';
      };
  };
}
