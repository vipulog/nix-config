{
  pkgs,
  config,
  lib,
  ...
}: let
  greeterExe = lib.getExe pkgs.greetd.tuigreet;
  sessionExe = lib.getExe' pkgs.niri "niri-session";
  autoLoginCfg = config.autoLogin;
in {
  imports = [
    ./greetd.nix
    ./niri.nix
  ];

  config.services.greetd.settings = {
    default_session = {
      command = ''
        ${greeterExe} --asterisks --time \
          --time-format '%I:%M %p | %a • %h | %F' \
          --cmd ${sessionExe}
      '';
    };

    initial_session = lib.mkIf autoLoginCfg.enable {
      command = "${sessionExe}";
    };
  };
}
