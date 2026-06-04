{ code-cursor, appimageTools, fetchurl }:

code-cursor.overrideAttrs (old: rec {
  version = "3.6.21";
  src = appimageTools.extract {
    pname = "cursor";
    version = "3.6.21";
    src = fetchurl {
      url = "https://downloads.cursor.com/production/e7a7e93f4d75f8272503ecf33cedbaae10114a15/linux/x64/Cursor-3.6.21-x86_64.AppImage";
      hash = "sha256-6zIhSz5fxEMLA8zd6oZtwNDUMAW65bZu/fYMSV/Iuh0=";
    };
  };
  sourceRoot = "cursor-${version}-extracted/usr/share/cursor";
})
