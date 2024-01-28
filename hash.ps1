$JrxmlPath = "$Env:BUILD_SOURCESDIRECTORY"
$jsonPath = "$Env:BUILD_SOURCESDIRECTORY/application1.json"
$hashFolderPath = "$Env:BUILD_SOURCESDIRECTORY/CombinedFiles"
$repopath = "E:/WEL/CombinedFiles"

# Retrieve PAT from environment variable
$pat = "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"

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
cd E:/WEL
# Configure Git to use PAT for authentication
$null = git config --global http.extraheader "Authorization: bearer $pat"
# Push changes to remote repository
$null = git remote add origin1 
# Push changes to remote repository
$null = git remote -v 

# Push changes to remote repository
$null = git fetch origin1 master

# Push changes to remote repository
$null = git pull origin1 master 

# Set Git configuration
$null = git config --global user.email "you@e.com"
$null = git config --global user.name "Name"

# Initialize Git repository
$null = git init

# Add files to Git staging area
$null = git add CombinedFiles/CardPayMoneyInMetering_hash.txt

# Commit changes
$null = git commit -m "Commit message"


# Push changes to remote repository
$null = git push origin master
