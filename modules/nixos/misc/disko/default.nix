{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.misc.disko;
  layoutsDir = ./layouts;

  builtinLayouts =
    mapAttrs
    (name: _: import (layoutsDir + "/${name}"))
    (builtins.readDir layoutsDir);

  applyLayout = layout: params:
    if builtins.isFunction layout
    then layout params
    else layout;

  resolveLayout = layout: params: let
    resolvedLayout =
      if builtins.isString layout
      then builtinLayouts.${layout} # Lookup built-in layout by name
      else if builtins.isPath layout
      then import layout # Import layout from path
      else layout; # Use direct layout (function or attrs)
  in
    applyLayout resolvedLayout params;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  options.internal.misc.disko = {
    enable = mkEnableOption "disk setup with Disko";

    layout = mkOption {
      description = "Disk layout configuration (function or attribute set)";
      type = with types;
        oneOf [
          str # Layout name from built-in layouts
          path # Path to a layout file
          (functionTo (attrsOf anything)) # Layout function
          (attrsOf anything) # Direct layout configuration
        ];
      default = "single-disk-ext4"; # Default to a built-in layout name
    };

    params = mkOption {
      description = "Parameters to pass to the selected layout";
      type = types.attrs;
      default = {};
    };

    builtinLayouts = mkOption {
      description = "Read-only access to all available built-in disk layouts";
      type = types.attrs;
      readOnly = true;
      default = builtinLayouts;
    };
  };

  config = mkIf cfg.enable {
    disko.devices = resolveLayout cfg.layout cfg.params;
  };
}
