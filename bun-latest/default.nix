{ pkgs, bun-source, ... }:

pkgs.bun.overrideAttrs (old: {
  version = "latest";
  src = bun-source;
  sourceRoot = "source";
})