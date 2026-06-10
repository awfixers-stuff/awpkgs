{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  alsa-lib,
  atk,
  at-spi2-atk,
  at-spi2-core,
  cairo,
  cups,
  dbus,
  expat,
  fontconfig,
  freetype,
  gdk-pixbuf,
  glib,
  gtk3,
  webkitgtk_4_1,
  libsoup_3,
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
  libXtst,
  libxcb,
  systemd,
  wayland,
}:

let
  # Bump when https://github.com/readest/readest/releases/latest changes.
  version = "0.11.4";
in
stdenv.mkDerivation {
  pname = "readest";
  inherit version;

  src = fetchurl {
    url = "https://github.com/readest/readest/releases/download/v${version}/Readest_${version}_amd64.deb";
    hash = "sha256-OwE9ITiNO7cU1EM0cTJCs3GMce9XhhOekywz/YzLuI0=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
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
    webkitgtk_4_1
    libsoup_3
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
    libXtst
    libxcb
    systemd
    wayland
    stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    runHook preUnpack
    ar x $src
    tar -xzf data.tar.*
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share

    install -Dm755 usr/bin/readest $out/bin/readest

    if [ -d usr/share/applications ]; then
      mkdir -p $out/share/applications
      install -m644 usr/share/applications/*.desktop $out/share/applications/
      substituteInPlace $out/share/applications/*.desktop \
        --replace-fail 'Exec=readest' "Exec=$out/bin/readest"
    fi

    if [ -d usr/share/icons ]; then
      cp -r usr/share/icons $out/share/
    fi

    runHook postInstall
  '';

  meta = {
    description = "Modern, feature-rich ebook reader";
    homepage = "https://github.com/readest/readest";
    changelog = "https://github.com/readest/readest/releases/tag/v${version}";
    license = lib.licenses.agpl3Plus;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "readest";
  };
}
