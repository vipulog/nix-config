{
  config,
  lib,
  ...
}: {
  options.autoLogin = {
    enable = lib.mkEnableOption "Enable automatic login";

    username = lib.mkOption {
      type = lib.types.str;
      default = "guest";
      description = "User to automatically login";
    };
  };

  config = {
    services.greetd = {
      enable = true;

      settings = {
        initial_session = lib.mkIf config.autoLogin.enable {
          user = "${config.autoLogin.username}";
        };
      };
    };
  };
}
