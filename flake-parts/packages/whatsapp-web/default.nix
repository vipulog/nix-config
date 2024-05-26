{lib, ...}: {
  perSystem = {pkgs, ...}: {
    packages.whatsapp-web = pkgs.callPackage pkgs.stdenv.mkDerivation {
      pname = "whatsapp-web";
      version = "1.0.0";
      nativeBuildInputs = [pkgs.makeWrapper];
      src = ./.;

      installPhase = ''
        install -Dm755 ${./src/whatsapp-web.sh} $out/bin/whatsapp-web
        wrapProgram $out/bin/whatsapp-web --prefix PATH : ${pkgs.brave}/bin
        install -Dm644 ${./assets/whatsapp-web.desktop} \
          $out/share/applications/whatsapp-web.desktop
        install -Dm644 ${./assets/whatsapp-icon.svg} \
          $out/share/icons/hicolor/scalable/apps/whatsapp-web.svg
      '';

      meta = {
        description = "Standalone WhatsApp Web launcher using Brave Browser’s app mode.";
        homepage = "https://web.whatsapp.com";
        platforms = lib.platforms.linux;
      };
    };
  };
}
