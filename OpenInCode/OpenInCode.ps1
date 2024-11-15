param (
    [string]$p4User,
    [string]$p4Client,
    [string]$p4Port,
    [string]$depotPath
)

Write-Host "Opening '$depotPath' ..."
Write-Host "Using P4 '$p4Client' '$p4Port' '$p4User'"

$result = & p4 -u $p4User -c $p4Client -p $p4Port where $depotPath
if ($result) {
    $localPath = $result -split "\s+" | Select-Object -Last 1

    if (Test-Path $localPath) {
        if (Test-Path $localPath -PathType Container) {
            # Open directories in new VS Code instances
            & "C:\Program Files\Microsoft VS Code\Code.exe" -n $localPath
        } else {
            # Open files in existing VS Code instance
            & "C:\Program Files\Microsoft VS Code\Code.exe" -r $localPath
        }
    } else {
        Write-Host "Error: Local path $localPath does not exist."
    }
} else {
    Write-Host "Error: Unable to retrieve local path for depot path $depotPath"
}
