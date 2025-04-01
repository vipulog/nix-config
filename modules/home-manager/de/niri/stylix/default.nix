{inputs, ...}: {
  imports = [inputs.niri.homeModules.stylix];
  config.internal.misc.stylix.enable = true;
}
