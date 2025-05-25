# removecamscanner script
$rmpath = "D:\skp\"

#Assosiacte pro-rename,pro-assets, pro-backup
$propath = "~\Downloads\aktualisasi latsar-20241208T125518Z-001/"
#Assosiacte doc-rename
$docpath = "D:\lecture\publikasi2025\"

#Assosiacte compress-rename
$comdocpath = "~\Downloads"

#doc-rename script
$docFiles = ".*.pdf|.*.doc|.*.docx|.*.pptx|.*.xlsx"

# pro-rename script
$rawFiles = ".*.jpg|.*.png|.*.jpeg|.*.tif|.*.tiff|.*.bmp|.*.eps|.*.heic|.*.raw|.*.psb|.*.psdc|.*.webp|.*.pln|.*.pla|.*.blend|.*.tpl|.*.3dm|.*.3ds|.*.ai|.*.ind|.*.indb|.*.inx|.*.idml|.*.pmd|.*.psd|.*.psb|.*.dwg|.*.dgn|.*.dwf|.*.dxf|.*.skp|.*.rvt|.*.rfa|.*.rft|.*.rte|.*.doc|.*.docx|.*.xlsx|.*.pptx|.*.txt"
$revFiles = ".*.pln|.*.pla|.*.blend|.*.tpl|.*.3dm|.*.3ds|.*.ai|.*.ind|.*.indb|.*.inx|.*.idml|.*.pmd|.*.psd|.*.psb|.*.dwg|.*.dgn|.*.dwf|.*.dxf|.*.skp|.*.rvt|.*.rfa|.*.rft|.*.rte|.*.doc|.*.docx|.*.xlsx|.*.pptx|.*.txt"
$verFiles = ".*.pdf|.*.jpg|.*.png|.*.jpeg|.*.tif|.*.tiff|.*.bmp|.*.eps|.*.heic|.*.raw|.*.psb|.*.psdc|.*.webp"

# pro-backup moving certain file script
$transferFiles = '*.pln','*.pla','*.blend','*.tpl','*.3dm','*.3ds','*.ai','*.ind','*.indb','*.inx','*.idml','*.pmd','*.psd','*.psb','*.dwg','*.dgn','*.dwf','*.dxf','*.skp','*.rvt','*.rfa','*.rft','*.rte','*.doc','*.docx','*.xlsx','*.pptx','*.txt'


# pro-assets script
$assFiles = ".*.jpg|.*.png|.*.jpeg|.*.tif|.*.tiff|.*.bmp|.*.eps|.*.heic|.*.raw|.*.psb|.*.psdc|.*.webp|.*.pln|.*.pla|.*.blend|.*.tpl|.*.3dm|.*.3ds|.*.ai|.*.ind|.*.indb|.*.inx|.*.idml|.*.pmd|.*.psd|.*.psb|.*.dwg|.*.dgn|.*.dwf|.*.dxf|.*.skp|.*.rvt|.*.rfa|.*.rft|.*.rte|.*.doc|.*.docx|.*.xlsx|.*.pptx|.*.txt|.*.pdf"


# addwatermark script
$stampcheckFile = "$PSScriptRoot\watermark\trans_stamp3.png"

# pro-clean script
$cleanFiles ='*.bak','*.dwl','*.dwl2', '*.skb', '*.log'
