#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

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

# Enable git auto-complete
# From: https://www.macinstruct.com/tutorials/how-to-enable-git-tab-autocomplete-on-your-mac/
if [ -f $SCRIPT_DIR/.git-completion.bash ]; then
  . $SCRIPT_DIR/.git-completion.bash
fi
