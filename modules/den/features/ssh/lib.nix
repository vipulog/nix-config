{
  flake.lib.den.ssh = {
    mkHostIdFilePath = {host}: "/etc/ssh/host_${host.name}";

    mkUserIdFilePath = {
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
        then "id_${username}"
        else "id_${username}_${hostname}";
    in
      if name == null
      then null
      else ".ssh/${name}";
  };
}
