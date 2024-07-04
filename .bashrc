#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

case ${TERM} in
  Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|tmux*|xterm*)
    PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')

    ;;
  screen*)
    PROMPT_COMMAND+=('printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
    ;;
esac

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

eval "$(starship init bash)"

# user defined config
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias ..='cd ..'
alias c='clear'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias grep='grep --color=auto'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias vim="nvim"

# Extracts any archive(s) (if unp isn't installed)
ex () {
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

mkcdir()
{
	mkdir -p -- "$1" &&
		cd -P -- "$1"
}

# Define the fzfd function
function fzfd() {
    sh ~/.local/bin/tmux-sessionizer.sh
}

# Bind Ctrl-f to the fzfd function
bind '"\C-f":"fzfd\n"'

# Neovim
export PATH="$PATH:/opt/nvim-linux64/bin"

# Setting $XDG_CONFIG_HOME
export XDG_CONFIG_HOME=$HOME/.config

# Setting up android cmdline
export ANDROID_HOME="/opt/android-sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
export PATH=$JAVA_HOME/bin:$PATH
export CHROME_EXECUTABLE=/bin/brave

export PATH="$PATH:`pwd`/flutter/bin"

