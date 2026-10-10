{
  den,
  lib,
  inputs,
  ...
}: {
  flake.lib.den.sops-nix = let
    secretsDir = "${inputs.my-secrets}/secrets/sops";
  in {
    sharedSecretsFilePath = "${secretsDir}/shared.yaml";

    mkHostSecretsFilePath = {host}: "${secretsDir}/${host.name}.yaml";

    mkUserSecretsFilePath = {
      host ? null,
      user ? null,
      home ? null,
    }: let
      hostname =
        if host != null
        then host.name
        else if home != null
        then home.hostName
        else null;

      username =
        if user != null
        then user.name
        else if home != null
        then home.userName
        else null;

      name =
        if username == null
        then null
        else if hostname == null
        then username
        else "${username}_${hostname}";
    in "${secretsDir}/${name}.yaml";

    hostHasSops = {host}:
      host.hasAspect den.aspects.sops-nix;

    userHasSops = {
      user ? null,
      home ? null,
    }:
      if home != null
      then home.hasAspect den.aspects.sops-nix
      else if user != null
      then user.hasAspect den.aspects.sops-nix
      else false;

    joinPath = segs: let
      clean = builtins.filter (s: s != null) segs;
      trimmed = map (s: lib.removeSuffix "/" (lib.removePrefix "/" s)) clean;
      nonEmpty = builtins.filter (s: s != "") trimmed;
    in
      "/" + lib.concatStringsSep "/" nonEmpty;
  };
}
