param(
    [string]$PluginRoot = (Split-Path -Parent $MyInvocation.MyCommand.Path),
    [string]$OutputDir = "dist"
)

$ErrorActionPreference = "Stop"

$PluginRoot = (Resolve-Path $PluginRoot).Path
$PluginFolderName = Split-Path -Path $PluginRoot -Leaf
$OutputPath = Join-Path $PluginRoot $OutputDir
$TempRoot = Join-Path $PluginRoot ".build_tmp"
$StageRoot = Join-Path $TempRoot $PluginFolderName
$ZipName = "$PluginFolderName.zip"
$ZipPath = Join-Path $OutputPath $ZipName

$excludePatterns = @(
    ".git*",
    ".vscode",
    ".idea",
    ".build_tmp",
    "dist",
    "__pycache__",
    "*.pyc",
    "*.pyo",
    "*.zip"
)

if (Test-Path $TempRoot) {
    Remove-Item -Path $TempRoot -Recurse -Force
}
if (-not (Test-Path $OutputPath)) {
    New-Item -Path $OutputPath -ItemType Directory | Out-Null
}

New-Item -Path $StageRoot -ItemType Directory -Force | Out-Null

Get-ChildItem -Path $PluginRoot -Force | Where-Object {
    $name = $_.Name
    foreach ($pattern in $excludePatterns) {
        if ($name -like $pattern) {
            return $false
        }
    }
    return $true
} | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $StageRoot -Recurse -Force
}

$StageLicense = Join-Path $StageRoot "LICENSE"
$StageLicenseTxt = Join-Path $StageRoot "LICENSE.txt"
if (-not (Test-Path $StageLicense) -and (Test-Path $StageLicenseTxt)) {
    Copy-Item -Path $StageLicenseTxt -Destination $StageLicense -Force
}

if (Test-Path $ZipPath) {
    Remove-Item -Path $ZipPath -Force
}

Compress-Archive -Path (Join-Path $TempRoot $PluginFolderName) -DestinationPath $ZipPath -CompressionLevel Optimal

Remove-Item -Path $TempRoot -Recurse -Force

Write-Host "ZIP generated: $ZipPath"
