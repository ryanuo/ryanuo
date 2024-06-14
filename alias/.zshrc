# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="random"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# aliases
# GitHub CLI operations
# Function to clone a repository from GitHub to the local machine
github_path="/C/sys/project/github" # Path where GitHub repositories are stored locally
gh_username="ryanuo"

cl() {
    repoName=$1  # Name of the repository to clone
    cd $github_path
    gh repo clone "$repoName" # Clone the repository using GitHub CLI
}

# Function to clone a personal repository, rename it, and reconfigure the Git settings
clm() {
    repoName=$1  # Name of the repository to clone
    destinationFolder=$2  # New name for the local repository folder
    cd $github_path
    # Clone the repository using GitHub CLI specifying the username
    gh repo clone "$gh_username/$repoName"
    
    # Move the cloned repository to a new folder with the specified name
    mv $repoName $destinationFolder
    
    # Enter the new folder, remove the existing .git folder, reinitialize Git, and set up the remote
    cd $destinationFolder
    rm -rf .git # Remove .git folder if it exists
    git init # Initialize a new Git repository
    git checkout -b main # Create a new branch 'main'
    git remote add origin "https://github.com/$gh_username/$destinationFolder.git" # Set the remote origin to the renamed repository
}

alias i='pnpm install' re='pnpm run release' d='pnpm run dev' b='pnpm run build'
