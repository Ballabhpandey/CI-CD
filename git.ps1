# Set the repository URL
$repoUrl = "https://github.com/Ballabhpandey/CI-CD.git"

# Clone the Git repository with GitHub PAT
$githubPat = $env:GitHubPat
git clone https://github.com/Ballabhpandey/CI-CD.git
cd CI-CD

# Get the list of commit hashes
$commitHashes = git log --format="%H"

# Initialize a hashtable to store changed files and their corresponding commit IDs
$changedFilesWithCommits = @{}

foreach ($commit in $commitHashes) {
    # Get the list of changed files for the current commit
    $changedFiles = git diff-tree --no-commit-id --name-only -r $commit

    foreach ($file in $changedFiles) {
        # Append the commit ID to the array corresponding to the file
        if (-not $changedFilesWithCommits.ContainsKey($file)) {
            $changedFilesWithCommits[$file] = @()
        }
        $changedFilesWithCommits[$file] += $commit
    }
}

# Output the list of changed files and their corresponding commit IDs
Write-Host "Changed files and their corresponding commit IDs:"
foreach ($file in $changedFilesWithCommits.Keys) {
    Write-Host "$file : $($changedFilesWithCommits[$file] -join ', ')"
}
# Sort commit hashes in descending order (latest commit first)
$commitHashes = $commitHashes | Sort-Object -Descending

# Initialize an array to store all the latest commit IDs
$latestCommits = @()

# Get the latest commit ID from the sorted list
$latestCommitId = $commitHashes[0]

# Collect all the latest commit IDs
foreach ($commit in $commitHashes) {
    if ($commit -eq $latestCommitId) {
        $latestCommits += $commit
    } else {
        break  # Exit the loop if the commit is not the latest
    }
}

# Output the latest commit IDs
Write-Host "Latest commits:"
foreach ($commit in $latestCommits) {
    Write-Host $commit
}


