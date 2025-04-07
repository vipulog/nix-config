{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    SF-Pro = pkgs.callPackage ./SF-Pro {};
    neovim = pkgs.callPackage ./neovim {inherit (inputs) nvf;};
  in {
    packages = {
      inherit SF-Pro neovim;
    };
  };
}
