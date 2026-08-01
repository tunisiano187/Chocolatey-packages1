$ErrorActionPreference = 'Stop'
$packageName    = 'gsuite-sync-outlook'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/google-apps-sync/enterprise_gsync.msi'
$url64          = 'https://dl.google.com/dl/google-apps-sync/x64/enterprise_gsync.msi'
$checksum       = '61202C94204327F9A05CF46371599700EC9984DBA46E1EC691FDE9D70B18B801'
$checksum64     = 'BA14AC483880D918309EB69B31D49410798E9947771F784580CB9A2F28AB97B6'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64          = $url64
  softwareName   = 'Google Apps Sync*'
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = $checksumType
  checksumType64 = $checksumType
  silentArgs     = ''
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# Update checksum variable

