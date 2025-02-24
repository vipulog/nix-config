{lib, ...}: {
  # use path relative to the root of the project
  relativeToRoot = lib.path.append ./.;

  getParentDirName = path: builtins.baseNameOf (builtins.dirOf path);
}
