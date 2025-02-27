{lib, ...}: {
  flake = {
    lib = import ./default {inherit lib;};
  };
}
