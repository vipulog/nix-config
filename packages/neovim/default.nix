{
  nvf,
  pkgs,
  ...
}:
(nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = [./config.nix];
})
.neovim
