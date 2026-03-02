param(
    [switch]$InstallMissing = $true
)

$ErrorActionPreference = 'Stop'

function Write-Status($msg) { Write-Host "[GCB2] $msg" }

function Test-FileAny {
    param([string[]]$Paths)
    foreach ($p in $Paths) {
        if (Test-Path $p) { return $true }
    }
    return $false
}

function Start-InstallerIfExists {
    param(
        [string]$RelativePath,
        [string]$Arguments = ''
    )

    $installer = Join-Path $PSScriptRoot $RelativePath
    if (-not (Test-Path $installer)) {
        Write-Status "Installer not found: $RelativePath"
        return $false
    }

    Write-Status "Running $RelativePath $Arguments"
    $proc = Start-Process -FilePath $installer -ArgumentList $Arguments -Verb RunAs -Wait -PassThru
    return ($proc.ExitCode -eq 0)
}

$os = Get-CimInstance Win32_OperatingSystem
$build = [int]$os.BuildNumber
if ($build -lt 22000) {
    Write-Status "Detected Windows build $build (pre-Windows 11). Continuing with dependency checks."
} else {
    Write-Status "Detected Windows 11 build $build."
}

$syswow = Join-Path $env:WINDIR 'SysWOW64'
$system32 = Join-Path $env:WINDIR 'System32'

# ---- Visual C++ runtime (x86) ----
$vcRuntimePresent = Test-FileAny @(
    (Join-Path $syswow 'vcruntime140.dll'),
    (Join-Path $system32 'vcruntime140.dll')
)

if ($vcRuntimePresent) {
    Write-Status 'Visual C++ runtime detected.'
} elseif ($InstallMissing) {
    Write-Status 'Visual C++ runtime not detected. Attempting bundled installer.'
    [void](Start-InstallerIfExists -RelativePath 'vcredist_x86.exe' -Arguments '/install /quiet /norestart')
} else {
    Write-Status 'Visual C++ runtime missing (InstallMissing disabled).'
}

# ---- OpenAL ----
$openAlPresent = Test-FileAny @(
    (Join-Path $syswow 'OpenAL32.dll'),
    (Join-Path $system32 'OpenAL32.dll')
)

if ($openAlPresent) {
    Write-Status 'OpenAL runtime detected.'
} elseif ($InstallMissing) {
    Write-Status 'OpenAL runtime not detected. Attempting bundled installer.'
    [void](Start-InstallerIfExists -RelativePath 'oalinst.exe' -Arguments '/s')
} else {
    Write-Status 'OpenAL runtime missing (InstallMissing disabled).'
}

# ---- Legacy DirectX components often required by older games ----
$directXLegacyPresent = Test-FileAny @(
    (Join-Path $syswow 'D3DX9_43.dll'),
    (Join-Path $system32 'D3DX9_43.dll')
)

if ($directXLegacyPresent) {
    Write-Status 'Legacy DirectX runtime components detected.'
} elseif ($InstallMissing) {
    Write-Status 'Legacy DirectX runtime components not detected. Attempting bundled web setup.'
    [void](Start-InstallerIfExists -RelativePath 'dxwebsetup.exe' -Arguments '/Q')
} else {
    Write-Status 'Legacy DirectX runtime components missing (InstallMissing disabled).'
}

Write-Status 'Prerequisite check complete.'
