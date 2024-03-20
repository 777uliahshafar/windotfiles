$files = Get-childitem -Path D:\assets

ForEach($file in $files){
    $CapitalizedName = (Get-Culture).textinfo.totitlecase($file.BaseName.tolower())
    $NameDotExt = "$CapitalizedName$($file.Extension)"
    Rename-item -Path $file.Fullname -NewName $NameDotExt
}
