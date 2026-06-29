# WORKAROUND:
# The niri-flake Nix module doesn't expose options for certain KDL config
# directives (e.g. background-effect for window blur). This workaround
# appends raw KDL from extras.kdl to the generated config using niri-flake
# internals (lib.internal.validated-config-for) and mkForce.
#
# WHEN TO REMOVE:
# Remove when niri-flake exposes the missing options natively, making the
# raw KDL supplement unnecessary.
niri-lib: {
  lib,
  pkgs,
  config,
  ...
}: {
  xdg.configFile.niri-config.source = let
    inherit (niri-lib.internal) validated-config-for;
    inherit (config.programs.niri) finalConfig package;
  in
    lib.mkForce (
      validated-config-for pkgs package ''
        ${finalConfig}
        ${builtins.readFile ../config/niri/extras.kdl}
      ''
    );
}
