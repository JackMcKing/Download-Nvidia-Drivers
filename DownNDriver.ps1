param (
	[string]$Action,
	[string]$Version,
	[string]$OutPath,
	[int]$ListNumber
)

Import-Module AngleParse

$HELP=@"

You can find lastest version on GEFORCE EXPERIENCE or following
https://www.nvidia.com/en-us/drivers/rtx-enterprise-and-quadro-driver-branch-history/
Unix archives: https://www.nvidia.com/en-us/drivers/unix/

Usage
	DownNDriver.ps1 [[-Action] <string>] [[-Version] <string>] [[-OutPath] <string>] [[-ListNumber] <int>]

Examples
	DownNDriver.ps1 -Action List-Versions
	DownNDriver.ps1 -Action List-Versions -ListNumber 10

	DownNDriver.ps1 -Action Download 471.11
	DownNDriver.ps1 -Action Download 471.11 -OutPath "D:\"

"@

function List-Versions {
	param ([int]$Number)
	Invoke-WebRequest "https://www.nvidia.com/en-us/drivers/rtx-enterprise-and-quadro-driver-branch-history/" | Select-HtmlContent "tr", @{ 
		Release_Branch = "tr td:nth-child(1)"
		Release_Update = "tr td:nth-child(2)"
		Version_Number = "tr td:nth-child(3)"
		Release_Date = "tr td:nth-child(4)"
	} | Select-Object -first ($Number + 2)
}

function Download {
	param (
		[string]$Driver_Version,
		[string]$Path
	)
	$Url="https://us.download.nvidia.cn/Windows/$Driver_Version/$Driver_Version-desktop-win10-64bit-international-dch-whql.exe"
	$whoami=whoami
	$iam=($whoami -split "\\")[-1]
	Write-Output "You are downloading $Driver_Version-desktop-win10-64bit-international-dch-whql.exe..."
	if ($Path) {
		Write-Output "File will be saved as $Path\$Driver_Version-desktop-win10-64bit-international-dch-whql.exe"
		Invoke-WebRequest -O $Path\$Driver_Version-desktop-win10-64bit-international-dch-whql.exe $Url
	} else {
		Write-Output "File will be saved as C:\Users\$iam\Downloads\$Driver_Version-desktop-win10-64bit-international-dch-whql.exe"
		Invoke-WebRequest -O C:\Users\$iam\Downloads\$Driver_Version-desktop-win10-64bit-international-dch-whql.exe $Url
	}
}

if ('List-Versions' -eq $Action) {
	List-Versions $ListNumber
} elseif ('Download' -eq $Action) {
	Download -Driver_Version $Version -Path $OutPath
} else {
	Write-Output $HELP
}
