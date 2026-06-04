{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  expat,
  fontconfig,
  freetype,
  gdk-pixbuf,
  glib,
  libdrm,
  libpulseaudio,
  libxkbcommon,
  mesa,
  nspr,
  nss,
  pango,
  libX11,
  libXcomposite,
  libXcursor,
  libXdamage,
  libXext,
  libXfixes,
  libXi,
  libXrandr,
  libXrender,
  libXScrnSaver,
  libXtst,
  libxcb,
  systemd,
  wayland,
}:

let
  version = "0.12.5.1";
in
stdenv.mkDerivation {
  pname = "helium";
  inherit version;

  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64_linux.tar.xz";
    hash = "sha256-tfiy1MkxXq9vOjp57R3ykHjleG0Viz/C2ttwXbHnPwA=";
  };

  sourceRoot = "helium-${version}-x86_64_linux";

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    libdrm
    libpulseaudio
    libxkbcommon
    mesa
    nspr
    nss
    pango
    libX11
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXScrnSaver
    libXtst
    libxcb
    systemd
    wayland
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/helium $out/bin

    # Install everything flat to lib/helium/
    cp -r ./* $out/lib/helium/

    # Remove the stock wrapper — we make our own
    rm -f $out/lib/helium/helium-wrapper

    # Ensure the executable bit (cp -r from the Nix store may strip it)
    chmod +x $out/lib/helium/helium

    # Create wrapper with correct environment
    makeWrapper $out/lib/helium/helium $out/bin/helium \
      --set CHROME_VERSION_EXTRA "nix" \
      --set CHROME_WRAPPER "$out/bin/helium" \
      --prefix LD_LIBRARY_PATH : "$out/lib/helium"

    # Desktop file
    mkdir -p $out/share/applications
    cp $out/lib/helium/helium.desktop $out/share/applications/
    substituteInPlace $out/share/applications/helium.desktop \
      --replace-fail "Exec=helium" "Exec=$out/bin/helium"

    # Icon
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp $out/lib/helium/product_logo_256.png \
      $out/share/icons/hicolor/256x256/apps/helium.png

    runHook postInstall
  '';

  preFixup = ''
    addAutoPatchelfSearchPath "$out/lib/helium"
  '';

  autoPatchelfIgnoreMissingDeps = [
    "libQt5Core.so.5"
    "libQt5Gui.so.5"
    "libQt5Widgets.so.5"
    "libQt6Core.so.6"
    "libQt6Gui.so.6"
    "libQt6Widgets.so.6"
  ];

  meta = {
    description = "Private, fast, and honest web browser based on Chromium";
    homepage = "https://github.com/imputnet/helium-linux";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "helium";
  };
}
