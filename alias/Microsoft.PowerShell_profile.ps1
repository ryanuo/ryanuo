
# GitHub CLI operations
# Function to clone a repository from GitHub to the local machine
$github_path="C:\sys\project\github" # Path where GitHub repositories are stored locally
$gh_username="ryanuo"

function cl {
    param(
        [string] $repoName # Name of the repository to clone
    )
    cd $github_path
    gh repo clone "$repoName" # Clone the repository using GitHub CLI
}

# Function to clone a personal repository, rename it, and reconfigure the Git settings
function clm {
    param(
        [string] $repoName, # Name of the repository to clone
        [string] $destinationFolder # New name for the local repository folder
    )
    cd $github_path
    # Clone the repository using GitHub CLI specifying the username
    gh repo clone "$gh_username/$repoName"
    
    # Move the cloned repository to a new folder with the specified name
    mv $repoName $destinationFolder
    
    # Enter the new folder, remove the existing .git folder, reinitialize Git, and set up the remote
    cd $destinationFolder
    Remove-Item .git -Recurse -Force -ErrorAction SilentlyContinue # Remove .git folder silently if it exists
    git init # Initialize a new Git repository
    git checkout -b main # Create a new branch 'main'
    git remote add origin "https://github.com/$gh_username/$destinationFolder.git" # Set the remote origin to the renamed repository
}

# pnpm cli
# pnpm install
function i {
    pnpm install
}
# pnpm run release
function re {
    pnpm run release
}
# pnpm run dev
function d {
    pnpm run dev
}
# pnpm run build
function b {
    pnpm run build
}