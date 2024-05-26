{
  lib,
  inputs,
  config,
  homename,
  namespace,
  ...
}: let
  cfg = config.${namespace}.misc.sops;
  inherit (config.home) homeDirectory;
  sopsFolder = builtins.toString inputs.nix-secrets + "/secrets/sops";
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  options.${namespace}.misc.sops = {
    enable = lib.mkEnableOption "sop";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = "${sopsFolder}/${homename}.yaml";
      age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";
    };
  };
}
