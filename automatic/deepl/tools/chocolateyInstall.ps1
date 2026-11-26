$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/0install/DeepLSetup.exe'
$checksum       = 'c0a01c1361213d505fda9feb17dadd3b2a534a0a90bc86b62bc80e760da333b6'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
