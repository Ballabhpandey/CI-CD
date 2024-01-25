# Set the repository URL
$repoUrl = "https://github.com/Ballabhpandey/CI-CD.git"

# Clone the Git repository with GitHub PAT
$githubPat = $env:GitHubPat
git clone https://github.com/Ballabhpandey/CI-CD.git
cd CI-CD
# Get the list of commit hashes
$commitHashes = git log --format="%H" 


# Initialize an empty array to store changed files
$allChangedFiles = @()

foreach ($commit in $commitHashes) {
    # Get the list of changed files for the current commit
    $changedFiles = git diff-tree --no-commit-id --name-only -r HEAD^

    # Append the changed files to the array
    $allChangedFiles += $changedFiles
}

# Remove duplicate file names
$allChangedFiles = $allChangedFiles | Sort-Object -Unique

# Output the list of changed files
Write-Host "Changed files:"
foreach ($file in $allChangedFiles) {
    Write-Host $file
}
# Commit and push changes
#git add .
#git commit -m "Update versions in jrxml files based on application.json"
#git push $repoUrl
