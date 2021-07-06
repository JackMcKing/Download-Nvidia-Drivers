# Download-Nvidia-Drivers

A powershell script for downloading Nvidia driver install files.

## Usage

`DownNDriver.ps1 [[-Action] <string>] [[-Version] <string>] [[-OutPath] <string>] [[-ListNumber] <int>]`

## Examples

```
DownNDriver.ps1 -Action List-Versions
DownNDriver.ps1 -Action List-Versions -ListNumber 10

DownNDriver.ps1 -Action Download 471.11
DownNDriver.ps1 -Action Download 471.11 -OutPath "D:\"
```
