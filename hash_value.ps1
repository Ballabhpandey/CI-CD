
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
cd  C:\ab\_work\1\s\CombinedFiles
git init 


  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

git config --list

 git remote set-url origin1 https://Ballabhpandey:ghp_u3yAvmhyEVa3X9GXqNqW73CszYVEpG31uP4@github.com/Ballabhpandey/CI-CD.git
git remote set-url --push origin1 https://Ballabhpandey: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@github.com/Ballabhpandey/CI-CD.git
#$null = git remote set-url origin1 git@github.com:Ballabhpandey/CI-CD.git 
# Push changes to remote repository
$null = git remote -v 

# Push changes to remote repository
$null = git fetch origin1 master
$null = git pull origin1 master

git status


git add CardPayMoneyInMetering_hash.txt CardPayMoneyInMeteringe_hash.txt CardPayStatement_hash.txt
git commit -m "sd"
 git status

 git push origin1 master
#git push -u https://Ballabhpandey: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@github.com/Ballabhpandey/CI-CD.git origin1 master






