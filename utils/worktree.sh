wt() {
    local branch="${1:?Usage: wt <branch>}"
    local git_common
    git_common="$(git rev-parse --git-common-dir 2>/dev/null)" || {
        echo "Not in a git repo" >&2
        return 1
    }

    local wt_path="$git_common/worktrees/$branch"

    # Check if this branch is already checked out in a worktree
    local existing
    existing="$(git worktree list --porcelain \
        | awk '/^worktree /{p=substr($0,10)} /^branch refs\/heads\//{b=substr($0,19)} /^$/{if(b==B)print p; b=""}  END{if(b==B)print p}' \
              B="$branch")"

    if [[ -n "$existing" ]]; then
        cd "$existing"
        return
    fi

    if git show-ref --verify --quiet "refs/heads/$branch"; then
        git worktree add "$wt_path" "$branch"
    else
        git worktree add -b "$branch" "$wt_path"
    fi || return 1

    cd "$wt_path"
}

wtl() {
    local dir
    dir="$(git worktree list | fzf --height=~100% | awk '{print $1}')" || return 1
    [[ -n "$dir" ]] || return 1
    cd "$dir"
}

wtr() {
    local git_common
    git_common="$(git rev-parse --git-common-dir 2>/dev/null)" || {
        echo "Not in a git repo" >&2
        return 1
    }
    cd "$git_common/.."
}
