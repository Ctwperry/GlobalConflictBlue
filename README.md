# GlobalConflictBlue

GlobalConflictBlue is a maritime warfare simulation project centered on the `GCB2` game build and data pack contained in this repository.

## Supported platforms

The packaged binary (`GCB2/bin/BlueII.exe`) and bundled redistributables indicate a **Windows-first runtime**.

- **Supported (runtime):**
  - Windows 10 (64-bit)
  - Windows 11 (64-bit)
- **May work with extra setup (not officially supported):**
  - Linux via Wine/Proton
  - macOS via virtualization or compatibility layers

If you run on non-Windows platforms, treat it as experimental and expect manual troubleshooting.

## Runtime dependencies

The repository already includes installers for the expected runtime dependencies in `GCB2/bin/`:

- Microsoft Visual C++ x86 Redistributable (`vcredist_x86.exe`)
- OpenAL runtime (`oalinst.exe`)
- DirectX runtime/web installer (`dxwebsetup.exe`)

Install these before first launch if the game fails to start cleanly.

## Reproducible local setup

This setup path avoids relying on a single external installer link.

1. **Clone the repository**
   ```bash
   git clone <your-fork-or-upstream-url>
   cd GlobalConflictBlue
   ```
2. **Install runtime prerequisites (Windows)**
   - Run, in order:
     - `GCB2/bin/vcredist_x86.exe`
     - `GCB2/bin/oalinst.exe`
     - `GCB2/bin/dxwebsetup.exe`
3. **Launch the game**
   - Start `GCB2/bin/BlueII.exe`.
4. **Verify data folders are present**
   - Confirm `GCB2/database`, `GCB2/maps`, `GCB2/scenarios`, and `GCB2/scripts` exist in your checkout.

## Windows 11 compatibility hardening

A deep dependency review of this build shows it relies on older redistributables that are commonly missing on fresh Windows 11 installs (especially 32-bit runtime components used by older game binaries).

To improve reliability on Windows 11, this repo now includes:

- `GCB2/bin/Windows11-Prerequisites.ps1`
  - Detects Windows build, checks for required runtime DLLs, and installs missing prerequisites from bundled installers when needed.
  - Checks include:
    - Visual C++ runtime (`vcruntime140.dll`)
    - OpenAL (`OpenAL32.dll`)
    - Legacy DirectX 9 helper DLLs (`D3DX9_43.dll`)
- `GCB2/bin/Launch-BlueII-Win11.bat`
  - Runs the prerequisite checker automatically, then launches `BlueII.exe`.

### Recommended launch flow on Windows 11

1. Right-click `GCB2/bin/Launch-BlueII-Win11.bat` and choose **Run as administrator** (first run).
2. Let prerequisite installers complete if prompted.
3. Launch again normally after prerequisites are installed.

This approach keeps startup reproducible and reduces common "missing DLL/runtime" crashes on Windows 11.

## Developer workflow (scripts/content)

Most modding work in this repository is content + Python script based.

### Script sanity check

Run a syntax pass on script files:

```bash
python3 -m py_compile GCB2/scripts/AI.py
```

You can expand this to all scripts as part of CI in a future update.

## Improvement roadmap

To keep project quality moving forward, prioritize the following:

1. Add CI checks for Python script syntax and lightweight linting.
2. Reduce wildcard imports in high-churn AI scripts.
3. Add validation tooling for scenario/database consistency.
4. Add contribution guidelines and release/versioning workflow.
