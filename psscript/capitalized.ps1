$files = Get-childitem -Path C:\folder

ForEach($file in $files){
    $CapitalizedName = (Get-Culture).textinfo.totitlecase($file.BaseName.tolower())
    $NameDotExt = "$CapitalizedName$($file.Extension)"
    Rename-item -Path $file.Fullname -NewName $NameDotExt
}
