{pkgs, ...}:
pkgs.writeShellScriptBin "bemoji-tofi" ''
  export BEMOJI_PICKER_CMD="${pkgs.tofi}/bin/tofi --font monospace --prompt emoji: "
  exec ${pkgs.bemoji}/bin/bemoji "$@"
''
