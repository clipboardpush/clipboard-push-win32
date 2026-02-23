param(
    [string]$FilePath = "src/core/Version.h"
)

if (-not (Test-Path $FilePath)) {
    Write-Host "Version.h not found at $FilePath"
    exit 1
}

$content = Get-Content $FilePath
$newContent = @()
$found = $false

foreach ($line in $content) {
    if ($line -match '^#define APP_BUILD_NUMBER\s+(\d+)') {
        $oldBuild = [int]$matches[1]
        $newBuild = $oldBuild + 1
        $newLine = "#define APP_BUILD_NUMBER $newBuild"
        $newContent += $newLine
        $found = $true
        Write-Host "Updating Build Number: $oldBuild -> $newBuild"
    }
    else {
        $newContent += $line
    }
}

if ($found) {
    $newContent | Set-Content $FilePath -Encoding Ascii
    Write-Host "Version.h updated successfully."
} else {
    Write-Host "APP_BUILD_NUMBER not found in Version.h."
    exit 1
}