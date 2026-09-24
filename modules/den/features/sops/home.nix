{
  inputs,
  self,
  ...
}: {
  den.aspects.sops-nix.home-setup = let
    inherit (self.lib.den.sops-nix) mkUserSecretsFilePath;
    inherit (self.lib.den.ssh) mkUserIdFilePath;
  in {
    homeManager = {
      user,
      host ? null,
      config,
      ...
    }: let
      homeDir = config.home.homeDirectory;
      userIdFilePathRel = mkUserIdFilePath {inherit host user;};
      userIdFilePath = "${homeDir}/${userIdFilePathRel}";
    in {
      imports = [inputs.sops-nix.homeManagerModules.sops];

      sops = {
        defaultSopsFile = mkUserSecretsFilePath {inherit host user;};
        age.sshKeyPaths = [userIdFilePath];
      };
    };
  };
}
