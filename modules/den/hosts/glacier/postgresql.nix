{
  den.aspects.glacier.postgresql = {
    nixos = {
      services.postgresql.dataDir = "/srv/postgresql";

      systemd.tmpfiles.rules = [
        "d /srv/postgresql 0700 postgres postgres - -"
      ];
    };
  };
}
