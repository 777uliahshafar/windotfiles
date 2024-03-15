# Explicitly load the System.Drawing assembly
Add-Type -AssemblyName System.Drawing

# Set the folder path where the images are located
$folderPath = "D:\image-source"

# Set the output folder path where the compressed images will be saved
$outputFolderPath = "D:\image-destination"

# Check if the output folder exists, if not, create it
if (-not (Test-Path -Path $outputFolderPath)) {
    New-Item -ItemType Directory -Path $outputFolderPath | Out-Null
}

# Get all the image files in the folder
$imageFiles = Get-ChildItem -Path $folderPath -Filter *.jpg -File

# Set the desired compression quality (from 1 to 100, where 100 is the highest quality)
$compressionQuality = 20

# Get the JPEG codec info for saving the compressed images
$jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }

# Compress each image file and save it in the output folder
foreach ($file in $imageFiles) {
    $outputFilePath = Join-Path -Path $outputFolderPath -ChildPath $file.Name
    Write-Host "Compressing $($file.Name)..."
    try {
        $image = [System.Drawing.Image]::FromFile($file.FullName)
        $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters
        $encoder = [System.Drawing.Imaging.Encoder]::Quality
        $encoderParam = New-Object System.Drawing.Imaging.EncoderParameter($encoder, $compressionQuality)
        $encoderParams.Param[0] = $encoderParam
        $image.Save($outputFilePath, $jpegCodec, $encoderParams)
        Write-Host "Compression complete."
    }
    catch {
        Write-Host "Failed to compress $($file.Name): $_"
    }
}
