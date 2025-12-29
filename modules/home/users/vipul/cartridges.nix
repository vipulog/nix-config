{
  username,
  sopsCfg,
  sopsFile,
  ...
}: {
  pkgs,
  config,
  namespace,
  lib,
  ...
}: let
  cartridgesCfg = config.${namespace}.programs.cartridges;
  sgdbKeySopsPath = "keys/steam-grid-db/${username}";
in {
  config = lib.mkIf (sopsCfg.enable && cartridgesCfg.enable) {
    sops.secrets."${sgdbKeySopsPath}" = {
      path = "%r/secrets/steam-grid-db";
      inherit sopsFile;
    };

    nixpkgs.overlays = [
      (_final: prev: {
        cartridges = prev.symlinkJoin {
          name = "cartridges";
          paths = [prev.cartridges];
          buildInputs = [prev.makeWrapper];
          postBuild = let
            runtimeDir =
              if pkgs.stdenv.isDarwin
              then "\\$(getconf DARWIN_USER_TEMP_DIR)"
              else "\\$XDG_RUNTIME_DIR";

            sgdbKeyDconfPath = "/page/kramo/Cartridges/sgdb-key";
            rawPath = config.sops.secrets."${sgdbKeySopsPath}".path;
            secretPath = builtins.replaceStrings ["%r"] [runtimeDir] rawPath;
          in ''
            wrapProgram $out/bin/cartridges \
              --run "${pkgs.dconf}/bin/dconf \
                write ${sgdbKeyDconfPath} \"'\$(cat ${secretPath})'\""
          '';
        };
      })
    ];
  };
}
