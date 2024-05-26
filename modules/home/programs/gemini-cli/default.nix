{
  inputs,
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.gemini-cli;
  sopsEnabled = config.${namespace}.misc.sops.enable;
in {
  options.${namespace}.programs.gemini-cli = {
    enable = lib.mkEnableOption "gemini-cli";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.gemini-cli.enable = true;
      home.file.".gemini/settings.json".source =
        config.lib.file.mkOutOfStoreSymlink ./settings.json;
    }

    (lib.mkIf sopsEnabled (let
      sopsFolder = (builtins.toString inputs.nix-secrets) + "/secrets/sops";
      secretName = "keys/gemini-code-companion";
      secretPath = config.sops.secrets.${secretName}.path;
    in {
      sops.secrets.${secretName} = {
        sopsFile = "${sopsFolder}/shared.yaml";
      };

      home.sessionVariables = {
        GEMINI_API_KEY = "$(cat ${secretPath})";
      };
    }))
  ]);
}
