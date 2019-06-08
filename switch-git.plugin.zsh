# Switch Git Plugin for oh-my-zsh
#
# Easily navigate through repositories and branches on your machine using
# switch_git_repository and switch_git_branch.
#
# Requirements: fzf

alias sgr="switch_git_repository"
alias sgb="switch_git_branch"
alias sgl="switch_git_list"
alias sgu="switch_git_update"

SWITCH_GIT_BASE_PATH=~

function switch_git_update() {
    switch_git_repository switch-git pull
}
function switch_git_list_directories() {
    find $SWITCH_GIT_BASE_PATH -name .git -exec dirname {} \; -prune | grep -v "$HOME/.vim" 
}

function switch_git_list() {
    switch_git_list_directories | sed 's!.*/!!' | sort | uniq 
}

function switch_git_repository() {
    origin_directory=$(pwd)

    if [ -z "$1" ]
    then
        switch_git_repository $(switch_git_list | fzf)
    else
        repo=$(switch_git_list_directories | grep $1 | sort -s | head -1)
        if [ -z "$repo" ]
        then
            echo "Could not find repository related to $(tput setaf 226)$1"
        else
            cd $repo

            # If additional arguments are supplied, run these through git in the destination repository and return
            if [[ ! -z "$2" ]]
            then
                if [ -x "$(command -v tgit.sh)" ]
                then
                    tgit.sh "${@:2}"
                else
                    git "${@:2}"    
                fi

                cd $origin_directory
            fi
        fi
    fi
}

function switch_git_branch() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

function _switch_git_repository {
    local line

    reponames=$(switch_git_list)
    _arguments -C \
        "1: :($reponames)" \
        "*::arg:->args"
}

compdef _switch_git_repository switch_git_repository
