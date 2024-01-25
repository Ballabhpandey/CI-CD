# Set the repository URL
$repoUrl = "https://github.com/Ballabhpandey/CI-CD.git"

# Clone the Git repository with GitHub PAT
$githubPat = $env:GitHubPat
git clone https://github.com/Ballabhpandey/CI-CD.git
cd CI-CD

# Get the list of commit hashes
$commitHashes = git log --format="%H"

# Initialize a flag to track changes in jrxml files
$jrxmlChangesFound = $false

# Check for changes in jrxml files across all commits
foreach ($commit in $commitHashes) {
    # Get the list of changed jrxml files for the current commit
    $changedJrxmlFiles = git diff-tree --no-commit-id --name-only -r $commit -- '*.jrxml'

    # If there are changes in jrxml files, set the flag to true and exit the loop
    if ($changedJrxmlFiles) {
        $jrxmlChangesFound = $true
        break
    }
}

# Output the result
if ($jrxmlChangesFound) {
    Write-Host "Changes were found in jrxml files."
} else {
    Write-Host "No changes were found in jrxml files."
}
