# removecamscanner script
$rmpath = "path-to-execution-folder"

# pro-rename script
$renamepath = "D:\adil\"
$rawFiles = ".*.jpg|.*.png|.*.jpeg|.*.tif|.*.tiff|.*.bmp|.*.eps|.*.heic|.*.raw|.*.psb|.*.psdc|.*.webp"
$revFiles = ".*.pln|.*.pla|.*.blend|.*.tpl|.*.3dm|.*.3ds|.*.ai|.*.ind|.*.indb|.*.inx|.*.idml|.*.pmd|.*.psd|.*.psb|.*.dwg|.*.dgn|.*.dwf|.*.dxf|.*.skp|.*.rvt|.*.rfa|.*.rft|.*.rte|.*.doc|.*.docx|.*.xlsx|.*.pptx|.*.txt"
$verFiles = ".*.pdf"

# pro-backup moving certain file script
$source = "D:\adil\*" # it should include \*
$destination = "D:\adil\backup\"
$transferFiles = '*.pln','*.pla','*.blend','*.tpl','*.3dm','*.3ds','*.ai','*.ind','*.indb','*.inx','*.idml','*.pmd','*.psd','*.psb','*.dwg','*.dgn','*.dwf','*.dxf','*.skp','*.rvt','*.rfa','*.rft','*.rte','*.doc','*.docx','*.xlsx','*.pptx','*.txt'


# assets-rename script
$asspath = "D:\adil\assets"
$assFiles = ".*.jpg|.*.png|.*.jpeg|.*.tif|.*.tiff|.*.bmp|.*.eps|.*.heic|.*.raw|.*.psb|.*.psdc|.*.webp|.*.pln|.*.pla|.*.blend|.*.tpl|.*.3dm|.*.3ds|.*.ai|.*.ind|.*.indb|.*.inx|.*.idml|.*.pmd|.*.psd|.*.psb|.*.dwg|.*.dgn|.*.dwf|.*.dxf|.*.skp|.*.rvt|.*.rfa|.*.rft|.*.rte|.*.doc|.*.docx|.*.xlsx|.*.pptx|.*.txt|.*.pdf"


# addwatermark script
$stamppath = "D:\adil"
$stampcheckFile = "$PSScriptRoot\watermark\trans_stamp3.png"
