# PowerShell Scripts for GitHub Automation and pnpm Commands

This set of PowerShell scripts facilitates automation of GitHub operations and execution of pnpm commands, optimized for the Windows environment.

## Cloning a GitHub Repository

### Function: `cl`

This function enables the cloning of a specified GitHub repository to your local system.

#### Parameters:

- `repoName` (string): The name of the repository to be cloned.

#### Usage:

```powershell
cl -repoName "your-repo-name"
```
**Note:** Requires installation of the GitHub CLI.

## Cloning Personal Repositories and Resetting Git Configurations

### Function: `clm`

This function is designed to clone personal GitHub repositories, rename the local folder, and reset Git settings.

#### Parameters:

- `repoName` (string): The name of the repository to clone.
- `destinationFolder` (string): The new name for the local repository folder.

#### Usage:
```powershell
clm -repoName "your-repo-name" -destinationFolder "new-folder-name"
```

## pnpm Command Aliases

These functions serve to streamline common pnpm commands usage.

| Function | PNPM Command        | Description                                 | Usage   |
|----------|---------------------|---------------------------------------------|---------|
| `i`      | `pnpm install`      | Installs project dependencies               | `i`     |
| `re`     | `pnpm run release`  | Deploys the project                         | `re`    |
| `d`      | `pnpm run dev`      | Starts the development server               | `d`     |
| `b`      | `pnpm run build`    | Builds the project                          | `b`     |