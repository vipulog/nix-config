{
  den,
  lib,
  ...
}: {
  den.schema.user = {
    includes = [den.policies.persist-user];
    classes = lib.mkDefault ["homeManager"];
  };
}
