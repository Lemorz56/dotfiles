# GITSTATUS_LOG_LEVEL=DEBUG
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

. "$HOME/.cargo/env"

#NOTE: Envs
#export ZSH="$HOME/.oh-my-zsh"
#export PATH="$PATH:/usr/local/go/bin"
#export PATH="$PATH:$HOME/.dotnet"
#export PATH="$PATH:$HOME/.dotnet/tools"
#export PATH="$PATH:$HOME/.local/bin"
#export PATH="$PATH:$HOME/.dotnet/sdk/"
#export PATH="/home/linuxbrew/.linuxbrew/opt/postgresql@16/bin:$PATH"
#export PATH="/home/linuxbrew/.linuxbrew/opt/openjdk@17/bin:$PATH"
#export XDG_RUNTIME_DIR=$PREFIX/tmp
#export GPG_TTY=$(tty)
#export LANG=en_US.UTF-8
# export DISPLAY=$(ip route list default | awk '{print $3}'):0
# export DISPLAY=$(echo $(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0)
#export LIBGL_ALWAYS_INDIRECT=1
# export HTTP_PROXY=http://10.46.82.114:3128
# export HTTPS_PROXY=http://10.46.82.114:3128
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#export EDITOR=/usr/bin/vim
#export VISUAL=/usr/bin/vim
export EDITOR=nvim
export HOMEBREW_BREWFILE=~/.config/brewfile/Brewfile
export HOMEBREW_BUNDLE_FILE_GLOBAL=~/.config/brewfile/Brewfile
export HOMEBREW_BUNDLE_NO_VSCODE=1
export PANERU_CONFIG=~/.config/paneru/paneru.toml

export PATH=$PATH:$(go env GOPATH)/bin


alias bash='/opt/homebrew/opt/bash/bin/bash'

#NOTE: ZSH Config

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git kubectl kube-ps1 kubectx zsh-autosuggestions poetry web-search nats golang terraform fast-syntax-highlighting)
#source ~/kube-ps1/kube-ps1.sh
source $ZSH/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
KUBE_PS1_SYMBOL_USE_IMG=true
KUBE_PS1_SYMBOL_ENABLE=false

#NOTE: Completion
#source <(kubectl completion zsh)
#source <(kind completion zsh)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats 'on %b(%m|%u|%c)'

function fzf-preview {
    nvim $(fzf --preview='bat {} -f' --bind shift-up:preview-page-up,shift-down:preview-page-down)
}
alias pf='fzf-preview'

function azsub() {
    items=("dev" "qa" "prod")
    choice=$(printf "%s\n" "${items[@]}" | fzf)
    echo $choice
    if [ -z "$choice" ]; then
        az account set --subscription "epiroc-iop-$choice"
    fi
}

#NOTE: ALIASES
alias gst='git status'
alias gdelta='git diff | delta'
#alias k='kubectl'
alias python='python3'
alias lg="lazygit"
alias kks="k9s"
alias pip=pip3
#alias ls="eza --icons"
alias ls="eza --long --all --git --icons=auto"
alias llm="eza -l --sort=modified -all --git --icons=auto"
alias kks="k9s"
alias fm='fzf-make'
alias make='gmake'
alias kube="kubecolor"
alias bbic="brew update &&\
    brew bundle install --cleanup --global &&\
    brew upgrade"
alias bbc="brew bundle check --global --verbose --no-upgrade"

#NOTE: Dotfiles are managed with GNU Stow now (migrated from homeshick).
# Nothing needs to be sourced here for that — stow just symlinks files into
# place ahead of time. See ~/dotfiles/README.md.

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# eval "$(gh copilot alias -- zsh)"
# eval "$(gh copilot -p 'zsh')"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# Setup fzf opts
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_TMUX_OPTS=" -p90%,70% "
# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    eval $(ssh-agent -s)
#    echo "Run ssh-add to add the keys"
#fi

#WARNING: YAZI
# function y() {
# 	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
# 	yazi "$@" --cwd-file="$tmp"
# 	IFS= read -r -d '' cwd < "$tmp"
# 	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
# 	rm -f -- "$tmp"
# }

# . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

#NOTE: bindkey
bindkey '^ ' autosuggest-accept

# test() {
#     sleep 5
#     # Add the SSH key to the agentssh-add
#     ssh-add ~/.ssh/id_rsa
# }
#
# test &

# if [ -z "$TMUX" ]
# then
#     tmux attach -t TMUX || tmux new -s TMUX
# fi
#
source ~/.config/git-helpers.sh

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(atuin init zsh --disable-up-arrow)"

# Created by `pipx` on 2025-07-24 09:10:23
export PATH="$PATH:/Users/sebastian.mossberg/.local/bin"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
