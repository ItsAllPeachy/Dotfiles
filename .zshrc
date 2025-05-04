cat ~/.ascii | lolcat

parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p'
}
COLOR_DEF='%f'
COLOR_USR='%F{243}'
COLOR_DIR='%F{135}'
COLOR_GIT='%F{205}'
NEWLINE=$'\n'
setopt PROMPT_SUBST
export PROMPT='${COLOR_DIR}%~${COLOR_GIT}($(parse_git_branch))${COLOR_DEF}${NEWLINE}  ${COLOR_DIR}╰─➤%f '



alias fetchy="neofetch --source ~/.config/neofetch/pngs/image1.png "
alias please='sudo $(history -p !!)'
alias ShowOffTime='clear && fetchy && sleep 5s && grim ~/Pictures/Screenshot/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png'

export MANPAGER='nvim +Man!'
export XDG_DATA_DIRS=$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share

bindkey ';5C' forward-word
bindkey ';5D' backward-word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word


# pnpm
export PNPM_HOME="/home/lithium/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
