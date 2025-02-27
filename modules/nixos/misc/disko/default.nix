{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.misc.disko;
  layoutsDir = ./layouts;

  resolveLayout = layout: params:
    if builtins.isPath layout
    then let
      loaded = import layout;
    in
      if builtins.isFunction loaded
      then loaded params
      else loaded
    else if builtins.isFunction layout
    then layout params
    else layout;

  layouts =
    builtins.mapAttrs
    (name: _: import (layoutsDir + "/${name}"))
    (builtins.readDir layoutsDir);
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  options.internal.misc.disko = {
    enable = mkEnableOption "disk setup with Disko";

    layout = mkOption {
      description = "Disk layout configuration";
      type = with types;
        oneOf [
          path
          (functionTo (attrsOf anything))
          (attrsOf anything)
        ];
      default = layouts.single-disk-ext4;
    };

    params = mkOption {
      description = "Parameters to pass to the selected layout.";
      type = types.attrs;
      default = {};
    };

    layouts = mkOption {
      description = "Read-only access to all available disk layouts.";
      type = with types;
        oneOf [
          (functionTo (attrsOf anything))
          (attrsOf anything)
        ];
      readOnly = true;
      default = layouts;
    };
  };

  config = mkIf cfg.enable {
    disko.devices = resolveLayout cfg.layout cfg.params;
  };
}
