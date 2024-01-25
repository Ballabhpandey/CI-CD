# Set the repository URL
$repoUrl = "https://github.com/Ballabhpandey/CI-CD.git"

# Clone the Git repository with GitHub PAT
$githubPat = $env:GitHubPat
git clone https://github.com/Ballabhpandey/CI-CD.git
cd CI-CD

# Get the list of commit hashes
$commitHashes = git log --format="%H"

# Initialize a hashtable to store the latest commit ID for each jrxml file
$latestCommits = @{}

# Check for changes in jrxml files across all commits
foreach ($commit in $commitHashes) {
    # Get the list of changed jrxml files for the current commit
    $changedJrxmlFiles = git diff-tree --no-commit-id --name-only -r $commit -- '*.jrxml'

    # If there are changes in jrxml files, update the latest commit ID for each file
    if ($changedJrxmlFiles) {
        foreach ($jrxmlFile in $changedJrxmlFiles) {
            $latestCommits[$jrxmlFile] = $commit
        }
    }
}

# Output the latest commit ID for each changed jrxml file
foreach ($file in $latestCommits.Keys) {
    $commitId = $latestCommits[$file]
    Write-Host "File: $file, Latest Commit ID: $commitId"
}
