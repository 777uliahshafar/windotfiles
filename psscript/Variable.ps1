# removecamscanner script
$rmpath = "path-to-execution-folder"

$propath = "D:\adil"

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
