param(
    [string]$FilePath = "src/core/Version.h",
    [string]$JsonPath = "version-win32.json"
)

if (-not (Test-Path $FilePath)) {
    Write-Host "Version.h not found at $FilePath"
    exit 1
}

$content = Get-Content $FilePath
$newContent = @()
$foundBuild = $false
$major = 0
$minor = 0
$patch = 0
$build = 0

foreach ($line in $content) {
    if ($line -match '^#define APP_VERSION_MAJOR\s+(\d+)') {
        $major = [int]$matches[1]
        $newContent += $line
    }
    elseif ($line -match '^#define APP_VERSION_MINOR\s+(\d+)') {
        $minor = [int]$matches[1]
        $newContent += $line
    }
    elseif ($line -match '^#define APP_VERSION_PATCH\s+(\d+)') {
        $patch = [int]$matches[1]
        $newContent += $line
    }
    elseif ($line -match '^#define APP_BUILD_NUMBER\s+(\d+)') {
        $oldBuild = [int]$matches[1]
        $build = $oldBuild + 1
        $newLine = "#define APP_BUILD_NUMBER $build"
        $newContent += $newLine
        $foundBuild = $true
        Write-Host "Updating Build Number: $oldBuild -> $build"
    }
    else {
        $newContent += $line
    }
}

if ($foundBuild) {
    $newContent | Set-Content $FilePath -Encoding Ascii
    Write-Host "Version.h updated successfully."
    
    # Generate JSON
    $versionStr = "v$major.$minor.$patch"
    $jsonObject = @{
        version_major = $major
        version_minor = $minor
        version_patch = $patch
        build = $build
        version_string = $versionStr
        changelog = "Auto-build update. (Build $build)"
        download_url = "https://clipboardpush.com/downloads/ClipboardPushWin32.exe"
    }
    $jsonObject | ConvertTo-Json | Set-Content $JsonPath
    Write-Host "Generated $JsonPath"
} else {
    Write-Host "APP_BUILD_NUMBER not found in Version.h."
    exit 1
}