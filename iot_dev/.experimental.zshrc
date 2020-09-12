# Path to your oh-my-zsh installation.
export ZSH="/home/soh0ro0t/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="random"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
# Set personal aliases
alias all_proxy="eval 'ALL_PROXY=socks5://192.168.253.1:10808'"
alias use_douban_pypi="eval 'PIP_INDEX_URL=https://pypi.douban.com/simple'"
alias startss="python ~/.local/lib/python2.7/site-packages/shadowsocks/local.py -c /etc/shadowsocks/shadowsocks.conf"

# Set personal environment virables 
export USE_CCACE=1
export LANG=en_US.UTF-8
export ANDROID_HOME=/home/soh0ro0t/Android/Sdk
export ANDROID_NDK=/opt/android-ndk/android-ndk-r16b
export ANDROID_NDK_ALONE=/opt/android-ndk-alone
export ANDROID_TUNA_REPO_URL='https://mirrors.tuna.tsinghua.edu.cn'
export PATH=/home/soh0ro0t/Android/Sdk/emulator:\
/home/soh0ro0t/Android/Sdk/tools/bin:\
/home/soh0ro0t/zsrc/tool/FunToys:/opt/cross_compile/nougat-release/bin:\
/opt/android-ndk/android-ndk-r16b:\
/home/soh0ro0t/zsrc/tool/cgdb/build/install/bin:\
~/zsrc/tool/fzf/bin:\
$PATH

# Load autojump plugin 
. /usr/share/autojump/autojump.sh

# Count shell depth
lvl() {
  local n=1 pid=$$ buf
  until
    IFS= read -rd '' buf < /proc/$pid/stat
    set -- ${(s: :)buf##*\)}
    ((pid == $4))
  do
    ((n++))
    pid=$2
  done
  echo $n
}

# Display current SHELL depth in zsh
PS1="[$(lvl)]$PS1"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line

# my custom key binding
bindkey "^a" beginning-of-line
bindkey "^u" backward-kill-line
bindkey "^e" end-of-line 

# Load fzf plugin for fuzzy find finder 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
