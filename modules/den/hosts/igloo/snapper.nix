{
  den.aspects.igloo.snapper = {
    nixos = {config, ...}: let
      mainDiskCfg = config.disko.devices.disk.main;
      subVols = mainDiskCfg.content.partitions.root.content.subvolumes;
      persistentMountpoint = subVols.persistent.mountpoint;
    in {
      services.snapper = {
        configs.persistent = {
          SUBVOLUME = persistentMountpoint;
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
