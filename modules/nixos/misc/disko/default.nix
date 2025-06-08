{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.misc.disko;
  layoutsDir = ./layouts;

  layouts = (
    builtins.mapAttrs (
      name: _: import "${layoutsDir}/${name}"
    ) (builtins.readDir layoutsDir)
  );

  resolveLayout = layout: params: (
    if isFunction layout
    then layout params
    else layout
  );
in {
  imports = [inputs.disko.nixosModules.disko];

  options.internal.misc.disko = {
    enable = mkEnableOption "disk setup with Disko";

    layout = mkOption {
      description = "Disk layout configuration";
      type = with types;
        oneOf [
          (functionTo (attrsOf anything))
          (attrsOf anything)
        ];
      default = config.internal.misc.disko.layouts.single-disk-ext4;
    };

    params = mkOption {
      description = "Parameters to pass to the selected layout";
      type = types.attrs;
      default = {};
    };

    layouts = mkOption {
      description = "Set of pre-configured disk layouts";
      type = types.attrs;
      readOnly = true;
      default = layouts;
    };
  };

  config = mkIf cfg.enable {
    disko.devices = resolveLayout cfg.layout cfg.params;
  };
}
