set -gx PATH /home/svart/.emacs.d/bin /home/svart/.cargo/bin $PATH

starship init fish | source

alias gst="git status"
alias gd="git diff"
alias ls="lsd"
alias ll="lsd -l"
alias vim="nvim"

alias hr 'history --merge'  # read and merge history from disk
