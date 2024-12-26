{ pkgs, home-manager, username, config, lib, ... }: let cfg = config.obs; in {

  options.obs.plugins.droidcam = {
    enable = lib.mkEnableOption "Virtual webcam using droidcam and v4l2loopback";
  };

  config = {
    home-manager.users.${username} = {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; []
          ++ lib.optional cfg.plugins.droidcam.enable droidcam-obs;
      };
    };

    # Droidcam-specific configuration - only when enabled
    boot = lib.mkIf cfg.plugins.droidcam.enable {
      extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
      kernelModules = [ "v4l2loopback" ];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="VWebCam" exclusive_caps=1
      '';
    };
  };
}
