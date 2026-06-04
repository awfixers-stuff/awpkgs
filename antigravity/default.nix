{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "antigravity";
  version = "2.0.11";

  src = pkgs.fetchurl {
    url = "https://storage.googleapis.com/antigravity-public/antigravity-hub/2.0.11-6560309696135168/linux-x64/Antigravity.tar.gz";
    hash = "sha256-obK1vw3l9DBMKYl/gappy4xW6KKVcKliuVOH68cr2VE=";
  };

  nativeBuildInputs = with pkgs; [ autoPatchelfHook makeWrapper copyDesktopItems ];

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "antigravity";
      exec = "antigravity";
      icon = "antigravity";
      desktopName = "Antigravity";
      genericName = "Antigravity Desktop App";
      categories = [ "Network" "Utility" ];
    })
  ];

  buildInputs = with pkgs; [
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libappindicator-gtk3
    libdrm
    libnotify
    libpulseaudio
    libuuid
    libxcb
    libxkbcommon
    mesa
    nss
    pango
    systemd
    libx11
    libxcb
    libxcomposite
    libxcursor
    libxdamage
    libxext
    libxfixes
    libxi
    libxrandr
    libxrender
    libxtst
    libxshmfence
  ];

  runtimeDependencies = with pkgs; [
    (lib.getLib systemd)
    libnotify
    libdbusmenu
    xdg-utils
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/antigravity
    cp -r * $out/share/antigravity

    chmod +x $out/share/antigravity/antigravity

    makeWrapper $out/share/antigravity/antigravity $out/bin/antigravity \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath runtimeDependencies}"

    runHook postInstall
  '';
}
