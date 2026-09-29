{den, ...}: {
  den.aspects.niri-de.dms.niri = {
    includes = with den.aspects.niri-de.dms.niri; [
      alttab
      binds
      colors
      cursor
      layout
      outputs
      windowrules
      wpblur
    ];

    homeManager = {lib, ...}:
      with den.aspects.niri-de.dms.niri; let
        files = {
          "alttab.kdl" = alttab.configKdl;
          "binds.kdl" = binds.configKdl;
          "colors.kdl" = colors.configKdl;
          "cursor.kdl" = cursor.configKdl;
          "layout.kdl" = layout.configKdl;
          "outputs.kdl" = outputs.configKdl;
          "windowrules.kdl" = windowrules.configKdl;
          "wpblur.kdl" = wpblur.configKdl;
        };
      in {
        home.activation.dmsNiriConfig = lib.hm.dag.entryAfter ["writeBoundary"] (
          lib.concatStringsSep "\n" (
            ["mkdir -p \"$HOME/.config/niri/dms\""]
            ++ lib.mapAttrsToList (name: contents: ''
              cat > "$HOME/.config/niri/dms/${name}" <<'EOF'
              ${contents}
              EOF
            '')
            files
          )
        );
      };
  };
}
