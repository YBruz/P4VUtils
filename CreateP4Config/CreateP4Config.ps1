param(
    [string]$u,
    [string]$c,
    [string]$p,
    [string]$r
)

# Check if the root directory is provided
if ($null -eq $r) {
    Write-Host "Error: Root directory (-r) is missing."
    exit
}

# Create a hashtable to store the parameters
$parameters = @{}
$parameters["P4USER"] = $u
$parameters["P4CLIENT"] = $c
$parameters["P4PORT"] = $p

Write-Host "Values:"
Write-Host "User: $u"
Write-Host "Client: $c"
Write-Host "Port: $p"
Write-Host "Root directory: $r"

# Define the file path
$filePath = Join-Path -Path $r -ChildPath ".p4config"

Write-Host "Writing to file: '$filePath'"

# Check if the file exists
if (Test-Path -Path $filePath) {
    Write-Host "File already exists. Updating file..."

    # Read the existing content
    $existingContent = Get-Content -Path $filePath

    # Update the existing content with the new parameters
    foreach ($key in $parameters.Keys) {
        $lineToUpdate = $existingContent | Where-Object { $_ -like "$key=*" }
        if ($null -ne $lineToUpdate) {
            $existingContent = $existingContent -replace $lineToUpdate, "$key=$($parameters[$key])"
        } else {
            $existingContent += "$key=$($parameters[$key])"
        }
    }

    # Write the updated content to the file
    $existingContent | Out-File -FilePath $filePath
} else {
    Write-Host "File does not exist. Creating file..."

    # Create the .p4config file
    $fileContent = ""
    foreach ($key in $parameters.Keys) {
        $fileContent += "$key=$($parameters[$key])`r`n"
    }

    # Write the content to the .p4config file
    $fileContent | Out-File -FilePath $filePath
}

Write-Host "P4 config file updated."
