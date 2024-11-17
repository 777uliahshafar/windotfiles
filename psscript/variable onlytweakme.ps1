# removecamscanner script
$rmpath = "path-to-execution-folder"

# pro-rename script
$renamepath = "path-to-execution-folder"
$rawFiles = ".*.jpg|.*.png|.*.jpeg|.*.tif|.*.tiff|.*.bmp|.*.eps|.*.heic|.*.raw|.*.psb|.*.psdc|.*.webp"
$revFiles = ".*.pln|.*.pla|.*.blend|.*.tpl|.*.3dm|.*.3ds|.*.ai|.*.ind|.*.indb|.*.inx|.*.idml|.*.pmd|.*.psd|.*.psb|.*.dwg|.*.dgn|.*.dwf|.*.dxf|.*.skp|.*.rvt|.*.rfa|.*.rft|.*.rte|.*.doc|.*.docx|.*.xlsx|.*.pptx|.*.txt"
$verFiles = ".*.pdf"
$files = Get-ChildItem -Path $path -Exclude *raw*, *rev*, *ver*

# pro-collect moving certain file script
$source = "path-to-source\*" # it should include \*
$destination = "path-to-destination"
$folder = 'path-to-folder' # Enter the root path you want to monitor.

# assets-rename script
$asspath = "D:\adil\assets"
$assFiles = ".*.jpg|.*.png|.*.jpeg|.*.tif|.*.tiff|.*.bmp|.*.eps|.*.heic|.*.raw|.*.psb|.*.psdc|.*.webp|.*.pln|.*.pla|.*.blend|.*.tpl|.*.3dm|.*.3ds|.*.ai|.*.ind|.*.indb|.*.inx|.*.idml|.*.pmd|.*.psd|.*.psb|.*.dwg|.*.dgn|.*.dwf|.*.dxf|.*.skp|.*.rvt|.*.rfa|.*.rft|.*.rte|.*.doc|.*.docx|.*.xlsx|.*.pptx|.*.txt|.*.pdf"


