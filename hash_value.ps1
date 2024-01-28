
$JrxmlPath = "$Env:BUILD_SOURCESDIRECTORY"
$jsonPath = "$Env:BUILD_SOURCESDIRECTORY/application1.json"
$hashFolderPath = "$Env:BUILD_SOURCESDIRECTORY/CombinedFiles"
$repopath = "$Env:BUILD_SOURCESDIRECTORY/CombinedFiles"

# Launch PowerShell with elevated privileges
Start-Process powershell.exe -Verb RunAs -ArgumentList "-File '$JrxmlPath/script.ps1'"


# Get all JRXML files in the specified directory
$jrxmlFiles = Get-ChildItem -Path $JrxmlPath -Filter *.jrxml

# Create a folder to store all files
$combinedFolderPath = Join-Path -Path $JrxmlPath -ChildPath "CombinedFiles"
New-Item -ItemType Directory -Path $combinedFolderPath -Force

# Calculate and create hash files for each JRXML file
foreach ($file in $jrxmlFiles) {
    $hash = Get-FileHash -Path $file.FullName -Algorithm SHA256
    $hashFileName = Join-Path -Path $repopath -ChildPath "$($file.BaseName)_hash.txt"
    Set-Content -Path $hashFileName -Value $hash.Hash
    Write-Output "File: $($file.Name), Hash: $($hash.Hash), Hash File: $($hashFileName)"
}
cd D:\a\1\s\CombinedFiles
git init 

$gitignorePath = "$Env:BUILD_SOURCESDIRECTORY\.gitignore"  # Path to .gitignore file

# Pattern to ignore .jrxml files
$ignorePattern = "*.jrxml"

# Check if .gitignore file already exists
if (Test-Path $gitignorePath) {
    # If .gitignore file exists, append the ignore pattern to it
    Add-Content -Path $gitignorePath -Value $ignorePattern
} else {
    # If .gitignore file doesn't exist, create it and add the ignore pattern
    New-Item -Path $gitignorePath -ItemType File -Force
    Set-Content -Path $gitignorePath -Value $ignorePattern
}

Write-Output "Added '$ignorePattern' to .gitignore file."

$null = git remote add origin1 https://github.com/Ballabhpandey/CI-CD.git
# Push changes to remote repository
$null = git remote -v 

# Push changes to remote repository
$null = git fetch origin1 master
$null = git pull origin1 master






