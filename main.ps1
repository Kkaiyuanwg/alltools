$urls = @(
    "https://dlcdnets.asus.com/pub/ASUS/GamingNB/Image/Driver/Graphics/25861/Graphic_DCH_ROG_NVIDIA_Z_V30.0.14.9649_25861_1.exe?model=ASUS%20TUF%20Gaming%20F15",
    "https://dlcdnets.asus.com/pub/ASUS/GamingNB/Image/Driver/Graphics/24235/Graphic_ROG_Intel_B_V30.0.100.9805Sub1_24235.exe?model=ASUS%20TUF%20Gaming%20F15"
)

$outputFolderPath = "C:\KAllTools"

# Create output folder if it doesn't exist
New-Item -ItemType Directory -Force -Path $outputFolderPath

foreach ($url in $urls) {
    $fileName = [System.IO.Path]::GetFileName($url)
    $outputFilePath = Join-Path -Path $outputFolderPath -ChildPath $fileName
    
    Write-Host "Downloading $fileName..."
    Invoke-WebRequest -Uri $url -OutFile $outputFilePath
    Write-Host "Downloaded $fileName to $outputFilePath"
}
