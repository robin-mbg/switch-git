# switch-git
oh-my-zsh plugin for easy switching between git repositories. Just type `sgr <some part of you repo's name>`, press enter and you're there. For additional features, see below.

## oh-my-zsh installation

1. Clone the git repository

```
git clone https://github.com/robin-mbg/switch-git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/switch-git
```

2. Enable the plugin in your `.zshrc`

```
plugins(
    ...
    ...
    switch-git)
```

To update the plugin, you can use the `sgu` (switch_git_update) command. This pulls the most recent version from git.

## Usage

switch-git provides you with the `sgr` (switch_git_repository) and `sgb` (switch_git_branch) commands. Feel free to shorten the commands further by setting other aliases in your `.zshrc`.

### Switch git repository

Simply calling `sgr` calls on a fuzzy-finding window provided by `fzf` to select one of your repositories. Instead of using the fuzzy finder, you can also directly add a search string. E.g. calling `sgr switch` may lead you to the switch-git repository on your local hard drive. 

### Temporary switching and git commands

switch-git also provides you with the ability to execute git commands in the found repository. If a command is provided the switch only happens temporarily in the background to execute the call. Your working directory will then be restored.

The following command, for example, goes to the switch-git repository, executes `git pull --rebase` and then restores the working directory.
```
sgr switch pull --rebase
```
### Switch git branch
The `sgb` command calls on an `fzf`-provided interface to select and check out a git branch. Instead of using the fuzzy finder, you can also directly add add a search string. E.g. calling `sgb feature` will lead to a switch to the latest-used feature branch. 
