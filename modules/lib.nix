{lib, ...}: {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = {};
    description = "Custom flake library.";
  };
}
