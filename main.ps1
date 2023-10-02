$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12


$amdd = "https://drivers.amd.com/drivers/installer/23.20/whql/amd-software-adrenalin-edition-23.9.3-minimalsetup-230926_web.exe"
$inteld = "https://downloadmirror.intel.com/788789/gfx_win_101.4826.exe"
$nvidiagd = "https://www.nvidia.es/content/DriverDownloads/confirmation.php?url=/Windows/537.42/537.42-notebook-win10-win11-64bit-international-dch-whql.exe&lang=es&type=geforcem"

$mas = "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/Separate-Files-Version/Activators/HWID_Activation.cmd"

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$cpuInfo = Get-WmiObject -Class Win32_Processor | Select-Object -Property Name
$gpuInfo = Get-WmiObject -Class Win32_VideoController | Select-Object -Property Name

Function Detectsys {
    
}

Function Drivers {
    Write-Host "Checking for GPU or CPU..."
    if ($gpuInfo.Name -like '*NVIDIA*') {
        Write-Host "NVIDIA GPU detected"
        Start-Process -FilePath "cmd" -ArgumentList "/c start $nvidiagd"
        if ($cpuInfo.Name -like '*AMD*') {
            Write-Host "AMD CPU detected"
            Start-Process -FilePath "cmd" -ArgumentList "/c start $amdd"
        } elseif ($cpuInfo.Name -like '*INTEL*') {
            Write-Host "INTEL CPU detected"
            Start-Process -FilePath "cmd" -ArgumentList "/c start $inteld"
        }
    } elseif ($gpuInfo.Name -like '*AMD*') {
        Write-Host "AMD GPU detected"
        Start-Process -FilePath "cmd" -ArgumentList "/c start $amdd"
        if ($cpuInfo.Name -like '*INTEL*') {
            Write-Host "INTEL CPU detected"
            Start-Process -FilePath "cmd" -ArgumentList "/c start $inteld"
        } else {
            break
        }
    } elseif ($gpuInfo.Name -like '*INTEL*') {
        Write-Host "INTEL GPU detected"
        Start-Process -FilePath "cmd" -ArgumentList "/c start $inteld"
        if ($cpuInfo.Name -like '*AMD*') {
            Write-Host "AMD CPU detected"
            Start-Process -FilePath "cmd" -ArgumentList "/c start $amdd"
        } else {
            break
        }
    } else {
        Write-Host "Undetected GPU, skipping..."
        if ($cpuInfo.Name -like '*AMD*') {
            Write-Host "AMD CPU detected"
            Start-Process -FilePath "cmd" -ArgumentList "/c start $amdd"
        } elseif ($cpuInfo.Name -like '*INTEL*') {
            Write-Host "INTEL CPU detected"
            Start-Process -FilePath "cmd" -ArgumentList "/c start $inteld"
        } else {
            Write-Host "Undetected CPU, skipping..."
        }
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

    $FilePaths = @("$env:TEMP\AllTools*.cmd", "$env:SystemRoot\Temp\AllTools*.cmd")
    foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }
}

Function GetApps {
    Invoke-Expression "winget install Microsoft.VisualStudioCode"
    Invoke-Expression "winget install Brave.Brave"
    Invoke-Expression "winget install Discord.Discord"
    Invoke-Expression "winget install REALiX.HWiNFO"
    Clear-Host
}

Clear-Host


$loadingBar = "=========="
$length = $loadingBar.Length

# Calculate the time interval for each step
$animationTime = 2
$stepTime = ($animationTime * 1000) / $length

for ($i = 0; $i -lt $length; $i++) {
    Write-Host -ForegroundColor Cyan "                                                        
    _ _ _ _____ __    _____ _____ _____ _____                                     
    | | | |   __|  |  |     |     |     |   __|                                    
    | | | |   __|  |__|   --|  |  | | | |   __|                                    
    |_____|_____|_____|_____|_____|_|_|_|_____|    
                        to kkai all tools! v0.3
                                                                                                                                            
    "
    Write-Host -NoNewline $loadingBar.Substring(0, $i) -ForegroundColor Green
    Write-Host -NoNewline ">" -ForegroundColor Cyan
    Write-Host $loadingBar.Substring($i) -ForegroundColor White
    Start-Sleep -Milliseconds $stepTime
    Write-Host "`r"
    Clear-Host
}
Clear-Host

Write-Host "Select one option:"
Write-Host "1. Install drivers"
Write-Host "2. Activate windows with MAS by @massgravel"
Write-Host "3. Install common applications (Brave, vscode, Discord, hwinfo)"
Write-Host "3. Everything"
Dete

$option = Read-Host "Please choose a number (1, 2, 3): "

if ($option -eq "1") {
    Drivers
} elseif ($option -eq "2") {
    MAShwid
} elseif ($option -eq "3") {
    GetApps
} elseif ($option -eq "4") {
    Drivers
    MAShwid
    GetApps
} else {
    Write-Host "Unvalid number, choose between: (1, 2, 3)"
}