{
  config,
  lib,
  inputs,
  namespace,
  ...
}: let
  username = "vipul";
  cfg = config.${namespace}.users.${username};

  sopsCfg = config.${namespace}.misc.sops;
  sopsFile = inputs.my-secrets + "/secrets/sops/vipul.yaml";
  plainSecrets = inputs.my-secrets.secrets.${username};

  importUserModule = path: (
    lib.modules.importApply path {
      inherit username sopsCfg sopsFile plainSecrets;
    }
  );
in {
  imports = [
    (importUserModule ./git.nix)
    (importUserModule ./ssh.nix)
    (importUserModule ./atuin.nix)
    (importUserModule ./zen-browser.nix)
  ];

  options.${namespace}.users.${username} = {
    enable = lib.mkEnableOption "user \"${username}\"";
  };

  config = lib.mkIf cfg.enable {
    ${namespace}.programs.zsh.enable = true;

    home = {
      inherit username;
      homeDirectory = "/home/${username}";
    };
  };
}
