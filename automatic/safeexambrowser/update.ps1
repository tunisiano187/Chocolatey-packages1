import-module Chocolatey-AU

$releases = 'https://github.com/SafeExamBrowser/seb-win-refactoring/releases'


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $version = $download_page.Links | ? href -like '*releases/tag*' | % href | select -First 1
    $version = Split-Path $version -Leaf
    $download_page = Invoke-WebRequest -Uri ($releases + '/expanded_assets/' + $version)
    $url64 = $download_page.Links | ? href -match '.x64_Setup.msi$' | % href | select -First 1
    $url32 = $download_page.Links | ? href -match '.x86_Setup.msi$' | % href | select -First 1
    $version = (Split-Path ( Split-Path $url32 ) -Leaf).Substring(1)

    @{
        URL32   = 'https://github.com' + $url32
        URL64   = 'https://github.com' + $url64
        Version = $version
    }
}

update