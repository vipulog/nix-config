{
  lib,
  inputs,
  ...
}: {
  flake.lib.den.sops-nix = let
    secretsDir = "${inputs.my-secrets}/secrets/sops";
  in {
    sharedSecretsFilePath = "${secretsDir}/shared.yaml";

    mkHostSecretsFilePath = {hostname}: "${secretsDir}/${hostname}.yaml";

    mkUserSecretsFilePath = {
      username,
      hostname ? null,
    }: let
      name =
        if hostname == null
        then username
        else "${username}_${hostname}";
    in "${secretsDir}/${name}.yaml";

    joinPath = segs: let
      clean = builtins.filter (s: s != null) segs;
      trimmed = map (s: lib.removeSuffix "/" (lib.removePrefix "/" s)) clean;
      nonEmpty = builtins.filter (s: s != "") trimmed;
    in
      "/" + lib.concatStringsSep "/" nonEmpty;
  };
}
