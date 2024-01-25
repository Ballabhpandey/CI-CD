# Set the repository URL
$repoUrl = "https://github.com/Ballabhpandey/CI-CD.git"

# Clone the Git repository with GitHub PAT
$githubPat = $env:GitHubPat
git clone https://github.com/Ballabhpandey/CI-CD.git
cd CI-CD

# Get the list of commit hashes
$commitHashes = git log --format="%H"

# Initialize a hashtable to store changed jrxml files and their corresponding commit IDs
$jrxmlChanges = @{}

# Check for changes in jrxml files across all commits
foreach ($commit in $commitHashes) {
    # Get the list of changed jrxml files for the current commit
    $changedJrxmlFiles = git diff-tree --no-commit-id --name-only -r $commit -- '*.jrxml'

    # If there are changes in jrxml files, store them in the hashtable along with their commit IDs
    if ($changedJrxmlFiles) {
        foreach ($jrxmlFile in $changedJrxmlFiles) {
            if (-not $jrxmlChanges.ContainsKey($jrxmlFile)) {
                $jrxmlChanges[$jrxmlFile] = @()
            }
            $jrxmlChanges[$jrxmlFile] += $commit
        }
    }
}

# Output the changed jrxml files and their corresponding commit IDs
foreach ($file in $jrxmlChanges.Keys) {
    $commitIds = $jrxmlChanges[$file] -join ', '
    Write-Host "File: $file, Commit IDs: $commitIds"
}
