#https://safeexambrowser.org/about_overview_en.html

$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'safeexambrowser'
  fileType               = 'msi'
  url                    = 'https://github.com/SafeExamBrowser/seb-win-refactoring/releases/download/v3.9.0/SEB_3.9.0.787_x86_Setup.msi'
  checksum               = 'e7646b3b4051bbde672626131f9229741b962d629ad04e97d710466bbe8b639a'
  checksumType           = 'sha256'
  url64bit               = 'https://github.com/SafeExamBrowser/seb-win-refactoring/releases/download/v3.9.0/SEB_3.9.0.787_x64_Setup.msi'
  checksum64             = 'd386e656d69ad6717d8d90661583ad31caea550c98fd904942d5f488585fb178'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'SafeExamBrowser*'
}
Install-ChocolateyPackage @packageArgs
