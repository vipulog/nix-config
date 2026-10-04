{
  den,
  inputs,
  self,
  ...
}: {
  den.aspects.sops-nix.host-setup = let
    inherit (self.lib.den.sops-nix) mkHostSecretsFilePath joinPath;
    inherit (self.lib.den.ssh) mkHostIdFilePath;
  in {
    nixos = {
      host,
      config,
      ...
    }: let
      isEphemeral = host.hasAspect den.aspects.ephemeral-host;

      persistMp =
        if isEphemeral
        then config.ephemeral-host.persistentMountpoint
        else null;

      hostIdFilePath =
        if isEphemeral
        then joinPath [persistMp (mkHostIdFilePath {inherit host;})]
        else (mkHostIdFilePath {inherit host;});
    in {
      imports = [inputs.sops-nix.nixosModules.sops];

      sops = {
        defaultSopsFile = mkHostSecretsFilePath {inherit host;};
        age.sshKeyPaths = [hostIdFilePath];
      };
    };

    darwin = {host, ...}: let
      hostIdFilePath = mkHostIdFilePath {inherit host;};
    in {
      imports = [inputs.sops-nix.darwinModules.sops];

      sops = {
        defaultSopsFile = mkHostSecretsFilePath {inherit host;};
        age.sshKeyPaths = [hostIdFilePath];
      };
    };
  };
}
