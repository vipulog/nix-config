{
  config,
  namespace,
  lib,
  ...
}: let
  username = "vipul";
  cfg = config.${namespace}.users.${username};
  userEnabled = cfg.enable;
in {
  imports = [
    (lib.modules.importApply ./git.nix {inherit userEnabled;})
    (lib.modules.importApply ./ssh.nix {inherit username userEnabled;})
  ];

  options.${namespace}.users.${username} = {
    enable = lib.mkEnableOption "user \"${username}\"";
  };

  config = lib.mkIf userEnabled {
    ${namespace}.programs.zsh.enable = true;
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
    };
  };
}
