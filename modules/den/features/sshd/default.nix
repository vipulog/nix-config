{self, ...}: let
  inherit (self.lib.den.ssh) mkHostIdFilePath;
in {
  den.aspects.sshd = {
    os = {host, ...}: {
      services.openssh = {
        enable = true;

        hostKeys = [
          {
            path = mkHostIdFilePath {hostname = host.name;};
            type = "ed25519";
          }
        ];
      };
    };

    nixos = {
      services.openssh.settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
      };
    };

    darwin = {
      services.openssh.extraConfig = ''
        PermitRootLogin prohibit-password
        PasswordAuthentication no
      '';
    };

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.openssh];
    };

    persist-host = {host, ...}: {
      files = {
        "${mkHostIdFilePath {hostname = host.name;}}" = {
          enable = true;
          how = "symlink";
          configureParent = true;
          mode = "0600";
        };
      };
    };
  };
}
