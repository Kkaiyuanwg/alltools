$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$urls = @(
    "https://dlcdnets.asus.com/pub/ASUS/GamingNB/Image/Driver/Graphics/25861/Graphic_DCH_ROG_NVIDIA_Z_V30.0.14.9649_25861_1.exe?model=ASUS%20TUF%20Gaming%20F15",
    "https://dlcdnets.asus.com/pub/ASUS/GamingNB/Image/Driver/Graphics/24235/Graphic_ROG_Intel_B_V30.0.100.9805Sub1_24235.exe?model=ASUS%20TUF%20Gaming%20F15"
)
$mas = "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/Separate-Files-Version/Activators/HWID_Activation.cmd"

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')

Function Drivers {
    $FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\AllTools_$rand.cmd" } else { "$env:TEMP\AllTools_$rand.cmd" } 
    foreach ($url in $urls) {
        $fileName = [System.IO.Path]::GetFileName($url)
        $outputFilePath = Join-Path -Path $FilePath -ChildPath $fileName
        
        Write-Host "Downloading $fileName..."
        Invoke-WebRequest -Uri $url -OutFile $outputFilePath
        Write-Host "Downloaded $fileName to $outputFilePath"
    }
}

Function MAShwid {
    #Code by @massgravel on GitHub
    $FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\AllTools_$rand.cmd" } else { "$env:TEMP\AllTools_$rand.cmd" }
    $response = Invoke-WebRequest -Uri $mas -UseBasicParsing

    $ScriptArgs = "$args "
    $prefix = "@REM $rand `r`n"
    $content = $prefix + $response
    Set-Content -Path $FilePath -Value $content

    Start-Process $FilePath $ScriptArgs -Wait

    $FilePaths = @("$env:TEMP\MAS*.cmd", "$env:SystemRoot\Temp\MAS*.cmd")
    foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }
}

Write-Host "Select one option:"
Write-Host "1. Install intel and nvidia drivers"
Write-Host "2. Activate windwos with MAS by @massgravel"
Write-Host "3. Everything"

$option = Read-Host "Please choose a number (1, 2, 3): "

if ($option -eq "1") {
    Write-Host "Elegiste la Opción A. Realizando función para Opción A..."
} elseif ($option -eq "2") {
    Write-Host "Elegiste la Opción B. Realizando función para Opción B..."
} elseif ($option -eq "3") {

} else {
    Write-Host "Unvalid number, choose between: (1, 2, 3)"
}

