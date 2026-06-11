{ stdenv, makeWrapper, autoPatchelfHook,
  alsa-lib, dbus, glib, gtk3, pango, libx11, libxcomposite, libxdamage,
  libxext, libxfixes, libxrandr, libxcb, nss, nspr,
  atk, at-spi2-atk, cups, mesa, libdrm, libxkbcommon,
  zen-browser-source
}:

stdenv.mkDerivation {
  pname = "zen-browser";
  version = "latest";
  src = zen-browser-source;
  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];
  buildInputs = [
    alsa-lib dbus glib gtk3 pango libx11 libxcomposite libxdamage
    libxext libxfixes libxrandr libxcb nss nspr
    atk at-spi2-atk cups mesa libdrm libxkbcommon
  ];
  installPhase = ''
    mkdir -p $out/bin $out/lib
    cp -r * $out/lib/
    makeWrapper $out/lib/zen $out/bin/zen-browser
  '';
}