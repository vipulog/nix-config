{userEnabled}: {
  inputs,
  config,
  namespace,
  lib,
  ...
}: let
  sopsEnabled = config.${namespace}.misc.sops.enable;
  gitEnabled = config.${namespace}.programs.git.enable;
in {
  config = lib.mkIf (userEnabled && sopsEnabled && gitEnabled) {
    programs.git = {
      userName = inputs.nix-secrets.git.vipulog.name;
      userEmail = inputs.nix-secrets.git.vipulog.email;
    };
  };
}
