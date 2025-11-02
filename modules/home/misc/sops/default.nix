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
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  options.${namespace}.misc.sops = {
    enable = lib.mkEnableOption "sop";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = inputs.my-secrets + "/secrets/sops/${homename}.yaml";
      age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";
    };
  };
}
