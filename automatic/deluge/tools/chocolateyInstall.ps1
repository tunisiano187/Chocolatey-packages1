$ErrorActionPreference = 'Stop';

$url64      = 'https://ftp.osuosl.org/pub/deluge/windows/deluge-2.2.0-win64-setup.exe'
$checksum64 = 'b2e414dd9cf637d3ea9f5b783972bb36cbb801134b6df79d67c1c08f68f4e889'

$url        = 'https://ftp.osuosl.org/pub/deluge/windows/deluge-2.2.0-win32-setup.exe'
$checksum   = 'c35dbaea459fad5a3e45910735c1fffdfbbeab24296a0820878312df7285c2be'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = $url
  url64bit       = $url64
  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
