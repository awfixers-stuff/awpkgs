# CI helpers

## `build-packages.sh`

Builds every package exposed under `packages.x86_64-linux` in the flake. The script **exits with a non-zero status** if any `nix build` fails.

Optional environment variables:

- `AWPKGS_SYSTEM` — unused today (flake is x86_64-linux only)
- `AWPKGS_ARTIFACT_DIR` — where `.tar.gz` archives and `manifest.json` are written (default: `ci/out/artifacts`)

Local run:

```bash
chmod +x ci/build-packages.sh
ci/build-packages.sh
```

GitHub Actions runs the same script on push/PR to `main`/`master`. Workflow upload steps use `continue-on-error: true`, so a failed artifact or release upload does **not** fail the job after a successful build.