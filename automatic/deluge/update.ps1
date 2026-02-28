$ErrorActionPreference = 'Stop'
import-module Chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://ftp.osuosl.org/pub/deluge/windows/'

function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"       = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum64)'"
            "(^[$]url\s*=\s*)('.*')"         = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
    Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $links = $page.Links.href | Where-Object { $_ -match 'deluge-[\d.]+-win64-setup\.exe$' } | Sort-Object { [version]($_ -replace '.*deluge-([\d.]+)-win64.*','$1') } | Select-Object -Last 1
    $version = $links -replace '.*deluge-([\d.]+)-win64.*','$1'

    $url64  = "${releases}deluge-${version}-win64-setup.exe"
    $url32  = "${releases}deluge-${version}-win32-setup.exe"

    $Latest = @{
        URL64   = $url64
        URL32   = $url32
        Version = $version
    }
    return $Latest
}

update -ChecksumFor all
