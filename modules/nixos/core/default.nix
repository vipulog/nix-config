{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.custom.relativeToRoot "modules/custom/options")

    ./nix.nix
    ./localization.nix
    ./home-manager.nix
  ];

  security.sudo.extraConfig = ''
    Defaults lecture = never # rollback results in sudo lectures after each reboot, it's somewhat useless anyway
    Defaults pwfeedback # password input feedback - makes typed password visible as asterisks
    Defaults timestamp_timeout=60 # only ask for password every 1h
  '';
}
