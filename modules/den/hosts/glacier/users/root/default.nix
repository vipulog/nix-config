{self, ...}: {
  den.aspects."root@glacier" = {
    user = {config, ...}: {
      hashedPasswordFile = config.sops.secrets.root-password.path;

      openssh.authorizedKeys.keyFiles = [
        "${self}/modules/den/hosts/igloo/users/tux/res/id_tux_igloo.pub"
      ];
    };
  };
}
