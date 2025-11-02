{
  username,
  sopsCfg,
  sopsFile,
  ...
}: {
  config,
  namespace,
  lib,
  ...
}: let
  sshCfg = config.${namespace}.programs.ssh;
  gitCfg = config.${namespace}.programs.git;
  sshIdPath = "${config.home.homeDirectory}/.ssh/id_${username}";
in {
  config = lib.mkIf (sopsCfg.enable && sshCfg.enable) {
    sops.secrets = {
      "keys/ssh/${username}" = {
        inherit sopsFile;
        path = sshIdPath;
      };
    };

    programs.ssh.matchBlocks = lib.mkIf gitCfg.enable {
      "git" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = sshIdPath;
      };
    };
  };
}
