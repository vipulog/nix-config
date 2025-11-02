{
  lib,
  inputs,
  config,
  hostname,
  namespace,
  ...
}: let
  cfg = config.${namespace}.misc.sops;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  options.${namespace}.misc.sops = {
    enable = lib.mkEnableOption "sop";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = inputs.my-secrets + "/secrets/sops/${hostname}.yaml";
      age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };
  };
}
