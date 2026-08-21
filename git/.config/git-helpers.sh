#!/usr/bin/env bash

# Verify that it is a Git repository
function ensure_git_repo() {
    if ! git rev-parse --is-inside-work-tree &> /dev/null; then
        echo "Error: Not inside a Git repository"
        return 1
    fi
}
#
# Use fzf to switch to another git branch using fzf
function sfb() {
    ensure_git_repo || return 1

    local line branch
    line=$(git --no-pager branch -vv | fzf)
    branch=$(echo "$line" | sed -E 's/^[* ]+([^ ]+).*/\1/')
    git switch "$branch"
}

# Use fzf to find and delete a certain Git branch
# function dfb() {
#     ensure_git_repo || return 1
#
#     local line branch
#     line=$(git --no-pager branch -vv | fzf)
#     branch=$(echo "$line" | sed -E 's/^[* ]+([^ ]+).*/\1/')
#
#     echo "git branch -D $branch"
#     read -p "Are you sure you want to delete this branch? [y|n] " -n 1
#     echo ""
#
#     if [[ $REPLY =~ ^[Yy]$ ]]; then
#         git branch -D "$branch"
#     else
#         echo "Branch deletion aborted"
#     fi
# }

# Use fzf to rebase your branch onto a specific commit
function gri() {
    ensure_git_repo || return 1

    local line commit
    line=$(git log --color=always --pretty=oneline --abbrev-commit | fzf --ansi --reverse)

    # exit the function if no commit is selected
    if [[ -z "$line" ]]; then
        return
    fi

    commit=$(echo "$line" | sed -E "s/^([^ ]+).*/\1/")

    git rebase -i "$commit"
}
