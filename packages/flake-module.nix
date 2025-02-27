{
  perSystem = {pkgs, ...}: {
    packages.SF-Pro = pkgs.callPackage ./SF-Pro {inherit (pkgs) stdenv;};
  };
}
