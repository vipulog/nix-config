{
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.gemini-cli;
in {
  options.${namespace}.programs.gemini-cli = {
    enable = lib.mkEnableOption "gemini-cli";
  };

  config = lib.mkIf cfg.enable {
    programs.gemini-cli.enable = true;
    home.file.".gemini/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink ./settings.json;
  };
}
