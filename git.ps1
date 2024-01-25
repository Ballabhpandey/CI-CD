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
# Get the latest commit ID from the sorted list
$latestCommitId = $commitHashes[0]
write-host "latest $latestCommitId "
# Iterate over the hashtable to find the file corresponding to the latest commit ID
foreach ($file in $changedFilesWithCommits.Keys) {
    if ($changedFilesWithCommits[$file] -contains $latestCommitId) {
        Write-Host "Latest commit ID '$latestCommitId' is associated with file '$file'"
        break  # Exit the loop once the file is found
    }
}


