# Specify the directory containing your PNG files
$sourceDirectory = "C:\Users\uliah\pngfolder"

# Get all PNG files in the specified directory
$pngFiles = Get-ChildItem -Path $sourceDirectory -Filter "*.png"

# Load the necessary .NET assembly
Add-Type -AssemblyName System.Drawing

foreach ($pngFile in $pngFiles) {
    $image = [System.Drawing.Image]::FromFile($pngFile.FullName)
    $jpgPath = $pngFile.FullName.Replace(".png", ".jpg")
    $image.Save($jpgPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)

    # Dispose of the original image object (optional)
    $image.Dispose()
}
