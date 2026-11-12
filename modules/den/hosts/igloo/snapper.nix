{
  den.aspects.igloo.snapper = {
    nixos = {config, ...}: {
      services.snapper = {
        configs.persistent = {
          SUBVOLUME = config.ephemeral-host.persistMp;
          ALLOW_USERS = ["tux"];
          SYNC_ACL = true;
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
          TIMELINE_LIMIT_HOURLY = 12;
          TIMELINE_LIMIT_DAILY = 7;
          TIMELINE_LIMIT_WEEKLY = 0;
          TIMELINE_LIMIT_MONTHLY = 0;
          TIMELINE_LIMIT_QUARTERLY = 0;
          TIMELINE_LIMIT_YEARLY = 0;
        };
      };
    };
  };
}
