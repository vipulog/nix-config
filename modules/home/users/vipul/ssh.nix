{
  username,
  userEnabled,
}: {
  inputs,
  config,
  namespace,
  lib,
  ...
}: let
  sopsEnabled = config.${namespace}.misc.sops.enable;
  sshEnabled = config.${namespace}.programs.ssh.enable;
  gitEnabled = config.${namespace}.programs.git.enable;
  sopsFolder = builtins.toString inputs.nix-secrets + "/secrets/sops";
  sshIdPath = "${config.home.homeDirectory}/.ssh/id_${username}";
in {
  config = lib.mkIf (userEnabled && sopsEnabled && sshEnabled) {
    sops.secrets = {
      "keys/ssh/${username}" = {
        sopsFile = "${sopsFolder}/shared.yaml";
        path = sshIdPath;
      };
    };

    programs.ssh.matchBlocks = lib.mkIf gitEnabled {
      "git" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = sshIdPath;
      };
    };
  };
}
