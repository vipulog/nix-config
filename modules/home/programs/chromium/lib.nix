{
  lib,
  chromiumPackage,
  ...
}: let
  browserVersion = lib.versions.major chromiumPackage.version;

  createChromiumExtension = {
    id,
    sha256,
    version,
  }: let
    baseUrl = "https://clients2.google.com/service/update2/crx";
    queryParams = [
      "response=redirect"
      "acceptformat=crx2,crx3"
      "prodversion=${browserVersion}"
      "x=id%3D${id}%26installsource%3Dondemand%26uc"
    ];
  in {
    inherit id;
    crxPath = builtins.fetchurl {
      url = "${baseUrl}?${lib.concatStringsSep "&" queryParams}";
      name = "${id}.crx";
      inherit sha256;
    };
    inherit version;
  };
in {
  createChromiumExtensions = extensions:
    lib.map createChromiumExtension extensions;
}
