# Create a new file
New-Item -Path "$env:$(Build.SourcesDirectory)\file.txt" -ItemType "file" -Force

# Set content to the file
Set-Content -Path "$env:$(Build.SourcesDirectory)file.txt" -Value "Your content here"


git status 
git fetch origin master
git pull origin master
