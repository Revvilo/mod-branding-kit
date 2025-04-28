function Get-FileName($initialDirectory) {
    Add-Type -AssemblyName System.Windows.Forms
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.initialDirectory = $initialDirectory
    $openFileDialog.filter = "All files (*.*)| *.*"
    $openFileDialog.ShowDialog() | Out-Null
    return $openFileDialog.filename
}

Write-Output "Choose a video to convert."

$filePath = Get-FileName -initialDirectory Get-Location
# $inputFile = Read-Host -Prompt "Name of input video"
Write-Output "Converting $filePath to a gif. Saving to demonstration.gif..."
Start-Sleep 1

ffmpeg -i $filePath -loglevel error -stats -lavfi "fps=30,scale=1000:-1,split[s0][s1];[s0]palettegen=max_colors=128:stats_mode=diff[p];[s1][p]paletteuse=dither=bayer"  "demonstration.gif"

Write-Output "Done!"
Start-Sleep 2