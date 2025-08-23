$path = "."  # Ganti dengan path direktori tempat file Anda berada
$fileTypes = ".*.jpg|.*.bmp|.*.png|.*.gif|.*.tif"  # Menentukan jenis file yang akan diubah
$excludeFiles = @("bg.jpg", "chamaeleon_hochformat.png", "guide.png", "kopfhoerer.png")  # Daftar file yang dikecualikan
$files = Get-ChildItem -Path $path -Recurse | Where-Object { $_.Extension -match $fileTypes }

foreach ($file in $files) {
    # Mengecek apakah file termasuk dalam daftar pengecualian
    if ($excludeFiles -contains $file.Name) {
        continue  # Lewati file yang termasuk pengecualian
    }

    # Mendapatkan parent direktori level 1
    $parentDir1 = (Split-Path $file.DirectoryName -Parent | Split-Path -Leaf)

    # Membuat nama baru berdasarkan parent direktori level 1 dan nama file dalam lowercase
    $newName = "$parentDir1-$($file.Name.ToLower())"

    # Mengecek apakah nama file sudah sesuai dengan format yang diinginkan
    if ($file.Name -notlike "$parentDir1-*") {
        # Mendapatkan path lengkap untuk nama baru
        $newFullName = Join-Path $file.DirectoryName $newName

        # Merename file
        Rename-Item $file.FullName -NewName $newFullName
    }
}
