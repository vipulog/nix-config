{lib, ...}: {
  options.customOptions.autoLogin = {
    enable = lib.mkEnableOption "Enable automatic login";

    username = lib.mkOption {
      type = lib.types.str;
      description = "User to automatically login";
      example = "john_doe";
    };
  };
}
