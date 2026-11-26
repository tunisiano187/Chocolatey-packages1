$ErrorActionPreference = 'Stop'
import-module Chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$release = 'https://appdownload.deepl.com/windows/0install/DeepLSetup.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url = $release
	$File = Join-Path $env:TEMP "DeepLSetup.xml"
	Invoke-WebRequest -Uri "https://appdownload.deepl.com/windows/0install/deepl.xml" -OutFile $File
	[xml]$ver=Get-Content($File)

	# The feed used to nest every <implementation> exactly 3 <group> levels deep
	# (interface.group.group.group.implementation), which is what this used to query via dotted
	# property access. DeepL has since flattened newer releases to 2 levels of <group>, so that
	# fixed-depth path stopped matching anything past v26.1.1.19426 - AU kept re-publishing that
	# same stale version/checksum against $release's rolling (non-versioned) URL while the file it
	# actually serves kept moving forward with every new DeepL release, so every install eventually
	# downloaded a newer build than the checksum on file (confirmed: chocolatey.org is still on
	# 26.1.1.19426 while the live feed's newest entry is 26.11.1.21905, issue #100). Use a
	# namespace-aware XPath for "implementation anyWhere-Object in the document" instead of a fixed depth,
	# so it isn't tied to how many <group> levels the feed happens to nest today.
	$ns = New-Object System.Xml.XmlNamespaceManager($ver.NameTable)
	$ns.AddNamespace('zi', 'http://zero-install.sourceforge.net/2004/injector/interface')
	$version = $ver.SelectNodes('//zi:implementation', $ns) | ForEach-Object { $_.version } | Sort-Object { $_ -as [version] } | Select-Object -Last 1

	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -ChecksumFor 32
