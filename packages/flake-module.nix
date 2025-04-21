{...}: {
  perSystem = {pkgs, ...}: let
    SF-Pro = pkgs.callPackage ./SF-Pro {};
  in {
    packages = {
      inherit SF-Pro;
    };
  };
}
