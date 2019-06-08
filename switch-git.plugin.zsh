# Switch Git Plugin for oh-my-zsh
#
# Easily navigate through repositories and branches on your machine

alias sgr="switch_git_repository"
alias sgb="switch_git_branch"

function switch_git_repository() {
    if [ -z "$1" ]
    then
        cd $(find ~ -name .git -exec dirname {} \; -prune | fzf --prompt="Repo name > ")
    else
        cd $(find ~ -name .git -exec dirname {} \; -prune | grep $1 | sort -s | head -1)
    fi
}

function switch_git_branch() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

