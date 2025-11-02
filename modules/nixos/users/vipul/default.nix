{
  lib,
  pkgs,
  config,
  namespace,
  inputs,
  ...
}: let
  username = "vipul";
  cfg = config.${namespace}.users.${username};

  sopsCfg = config.${namespace}.misc.sops;
  sopsEnabled = sopsCfg.enable;
  sopsFile = inputs.my-secrets + "/secrets/sops/vipul.yaml";
  plainSecrets = inputs.my-secrets.secrets.${username};

  importUserModule = path: (
    lib.modules.importApply path {
      inherit username sopsCfg sopsFile plainSecrets;
    }
  );
in {
  imports = [
    (importUserModule ./home-manager.nix)
    (importUserModule ./podman.nix)
  ];

  options.${namespace}.users.${username} = {
    enable = lib.mkEnableOption "user \"${username}\"";

    isAdmin = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to add this user to the wheel group.";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        users.users.${username} = {
          isNormalUser = true;
          shell = pkgs.zsh;
          initialPassword = lib.mkIf (!sopsEnabled) "1";
          extraGroups = lib.mkIf (cfg.isAdmin) ["wheel"];
        };

        ${namespace}.programs.zsh.enable = true;
      }

      (lib.mkIf sopsEnabled {
        sops.secrets = {
          "passwords/${username}".neededForUsers = true;
        };

        users.users.${username}.hashedPasswordFile =
          config.sops.secrets."passwords/${username}".path;
      })
    ]
  );
}
