# Create a new file
$a = New-Item -Path "$env:Build.SourcesDirectory\file.txt" -ItemType "file" -Force
write-host "$a"
# Set content to the file
Set-Content -Path "$env:Build.SourcesDirectory\file.txt" -Value "Your content here"


git status 
git fetch origin master
git pull origin master
git add file.txt
git commit -m "dsa"
git push origin master
