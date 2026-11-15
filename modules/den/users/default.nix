{
  den,
  lib,
  ...
}: {
  den.schema.user = {
    includes = [
      den.policies.hm-overlays-to-host
      den.policies.persist-user
    ];

    classes = lib.mkDefault ["homeManager"];
  };
}
