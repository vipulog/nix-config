{
  flake.lib.den.ssh = {
    mkHostIdFilePath = {hostname}: "/etc/ssh/host_${hostname}";

    mkUserIdFilePath = {
      username,
      hostname ? null,
    }: let
      name =
        if hostname == null
        then "id_${username}"
        else "id_${username}_${hostname}";
    in ".ssh/${name}";
  };
}
