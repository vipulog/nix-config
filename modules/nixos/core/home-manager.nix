{inputs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bk";
    extraSpecialArgs = {inherit inputs;};
  };
}
