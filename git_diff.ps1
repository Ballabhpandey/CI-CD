# Set the repository URL
$repoUrl = "https://github.com/Ballabhpandey/CI-CD.git"

# Clone the Git repository with GitHub PAT
$githubPat = $env:GitHubPat
git clone https://github.com/Ballabhpandey/CI-CD.git
cd CI-CD
# Get the commit hash associated with the version being built
$commitHash = $env:BUILD_SOURCEVERSION
$commitMessage = $env:Build.SourceVersionMessage
write-host "commit message: $commitMessage"
write-host "commithash: $commitHash"

# Get the list of changed files since the specified commit
$changedFiles = git diff-tree --no-commit-id --name-only -r $commitHash
write-host "Changed file : $changedFiles "
$variableName = "REPORT_VERSION"

# Load version information from application.json
$jsonFilePath = "$Env:BUILD_SOURCESDIRECTORY\application1.json"
$json = Get-Content $jsonFilePath | ConvertFrom-Json

foreach ($file in $changedFiles) {
    if ($file -match "\.jrxml") {
        # There are changes in jrxml files

        # Extract application name from jrxml file name
        $applicationName = [System.IO.Path]::GetFileNameWithoutExtension($file)

        # Find the corresponding application in application.json
        $application = $json.applications | Where-Object { $_.name -eq $applicationName }

        if ($application -ne $null) {
            # Update version in jrxml file based on application version
            $version = $application.version
             $content = Get-Content $file 
           # $fileContent = $content -replace "(<variable name=""$variableName""[^>]*>\s*<variableExpression><!\[CDATA\[)""\d+(\.\d+)+""(]]><\/variableExpression>\s*<\/variable>)", "`$1""$appVersion""`$3"
          #  Set-Content -Path $file -Value $fileContent
            write-host "completed"
        }
    }else{write-host "there is no change in jrxml file "}
}

# Commit and push changes
#git add .
#git commit -m "Update versions in jrxml files based on application.json"
#git push $repoUrl
