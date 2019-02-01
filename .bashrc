# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi





function lazygit() {
	if [ -z $2 ]
	then
		git add . && git commit -m "$1" && git push origin "$1"
	else 
		git add . && git commit -m "$1" && git push origin "$2"
	fi
}


function pausarsonido() {
	if [ -z $1 ]
	then
		(amixer -q -D pulse sset Master 30% && sleep 410 && amixer -q -D pulse sset Master 70%)&
		disown
	else 
		(amixer -q -D pulse sset Master 30% && sleep $1 && amixer -q -D pulse sset Master 70%)&
		disown
	fi
}


alias updatenode='curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -'


alias kudoscontroldeploy='echo "Deploy KudosControl (kcontrol)" && cd /home/ezequiel/git/kudos/kudoscontrol && ./node_modules/@angular/cli/bin/ng build --prod && rsync -ah google/. dist/kudoscontrol/google/ && rsync --progress --exclude "assets/backend/cuentas/config.php" -ahe ssh dist/kudoscontrol/. kudos@www.kudosestudio.com:/home/kudos/kcontrol/'
alias logsreset='find . -path "*.log" -exec sh -c '\''gzip -c "$0" >> "$0_$(date -I).gz" && rm "$0"'\'' {} \;'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:/opt/mssql-tools/bin"

#ssh tiendalibero
alias sshtiendaliberostratus='echo "ssh tiendalibero prod" && ssh -p 20747 kudos@ssh-virginia-28.mojostratus.io'
alias sshtiendaliberoold="echo 'ssh tiendalibero prod old' && echo 'pass TiendaLINODE!1234!' && ssh root@45.79.218.74"
alias sshtiendalibero='echo "ssh tiendalibero prod new" && ssh tiendalibero@199.189.227.76'
#ssh kudos
alias sshkudos='echo "ssh kudos" && ssh kudos@162.252.106.81'
alias sshkudos2='echo "ssh kudos 2" && ssh kudos2@199.189.227.76'
#ssh raceparts
alias sshraceparts='echo ssh raceparts && ssh raceparts@raceparts.com.ar'
#ssh casavargas
alias sshcasavargas='echo ssh casavargas && ssh casavar@casavargas.com.ar'
#ssh nhautopiezas
alias sshnhautopiezas='echo "ssh nhautopiezas" && ssh nhautopiezas@nhautopiezas.com.ar'
#ssh pigmento
alias sshpigmentoprod='echo "ssh pigmento prod" && ssh -i ~/pigmento_key_prod.pem ubuntu@34.195.204.232'
alias sshpigmentostaging='echo "ssh pigmento staging" && ssh -i ~/pigmento_key_staging.pem ubuntu@52.202.123.212'
#ssh modax
alias sshmodaxprod='echo "ssh modax prod" && echo "pass: M4g3nt02017" && ssh root@modax.com.ar'
alias sshmodaxstaging='echo "ssh modax staging" && echo "pass: M4g3nt02017" && ssh root@magtest.modax.com.ar'
#ssh tiendalosangeles
alias sshtiendalosangeles='echo "ssh tiendalosangeles" && ssh tiendalosangeleskudos@tiendalosangeles.com.ar'
#ssh tucamara
alias sshtucamaraprod='echo "ssh tucamara prod" && ssh -i ~/tucamara.ppk tucamara@m76.siteground.biz -p18765'
#ssh parz
alias sshparz='echo "ssh parz" && ssh centos@ec2-18-224-117-22.us-east-2.compute.amazonaws.com -i ~/key-parz'
#ssh fiorani
alias sshfiorani='echo "ssh fiorani" && ssh fiorani@fiorani.com.ar'
#ssh nuevo kudos
alias sshkudos_nuevoservidor='echo ssh nuevo kudos && kudos@74.222.3.71'
