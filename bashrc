alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias vi=vim

export SVN_EDITOR=vim
alias rtest="ruby -Itest"

# I insist on bash vs. zsh.
# https://support.apple.com/en-us/102360
export BASH_SILENCE_DEPRECATION_WARNING=1

alias sn="screen -S"
alias sr="screen -d -r"
alias bz=bazel
