# Format Nix files according to RFC 166
format:
    find . -name "*.nix" -exec nixfmt {} +
