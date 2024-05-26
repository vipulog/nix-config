{
  lib,
  pkgs,
  config,
  inputs,
  hostname,
  namespace,
  ...
}: let
  username = "vipul";
  cfg = config.${namespace}.users.${username};
  sopsEnabled = config.${namespace}.misc.sops.enable;
in {
  options.${namespace}.users.${username} = {
    enable = lib.mkEnableOption "user \"${username}\"";

    isAdmin = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to add this user to the wheel group.";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      users.users.${username} = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = lib.optionals cfg.isAdmin ["wheel"];
        initialPassword = lib.optionalDrvAttr (!sopsEnabled) "1";
      };

      ${namespace}.programs.zsh.enable = true;
    }

    (lib.mkIf sopsEnabled (let
      sopsFolder = builtins.toString inputs.nix-secrets + "/secrets/sops";
      userCfg = config.users.users.${username};
    in {
      sops.secrets = {
        "passwords/${username}" = {
          sopsFile = "${sopsFolder}/shared.yaml";
          neededForUsers = true;
        };

        "keys/age/${username}_${hostname}" = {
          owner = userCfg.name;
          inherit (userCfg) group;
          path = "${userCfg.home}/.config/sops/age/keys.txt";
        };
      };

      users.users.${username}.hashedPasswordFile =
        config.sops.secrets."passwords/${username}".path;
    }))
  ]);
}
