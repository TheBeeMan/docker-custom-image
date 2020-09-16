# ======================================================
# Setting global system wide environment variable
# ======================================================
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:\
/code/home/soh0ro0t/tools/FunToys:\
~/Android/sdk/tools/bin:\
~/Android/Sdk/ndk/21.3.6528147:\
~/Android/Sdk/tools:\
~/Android/Sdk/tools/bin/:\
~/src/FunToys/:\
~/src/afl-cov/:\
/usr/lib/llvm-5.0/bin/:\
/usr/lib/llvm-8/bin/:\
$PATH
# Setting default fzf option
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ======================================================
# Setting a few convenient alias of commands
# ======================================================
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias gotools="cd ~/Android/Sdk/tools"
alias ll="ls -lF"

# ======================================================
# Load a branch of zsh plugins
# ======================================================
source ~/.zplug/init.zsh
        # Make sure to use double quotes
        zplug "zsh-users/zsh-history-substring-search"

        # Use the package as a command
        # And accept glob patterns (e.g., brace, wildcard, ...)
        zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

        # Can manage everything e.g., other person's zshrc
        zplug "tcnksm/docker-alias", use:zshrc

        # Disable updates using the "frozen" tag
        zplug "k4rthik/git-cal", as:command, frozen:1

        # TODO: Grab binaries from GitHub Releases
        # and rename with the "rename-to:" tag
        # zplug "junegunn/fzf-bin", \
        #       from:gh-r, \
        #       as:command, \
        #       rename-to:fzf, \
        #       use:"*darwin*amd64*"

        # TODO: Supports oh-my-zsh plugins and the like
        # zplug "modules/prompt", from:prezto

        # Load if "if" tag returns true
        zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

        # Run a command after a plugin is installed/updated
        # Provided, it requires to set the variable like the following:
        # ZPLUG_SUDO_PASSWORD="********"
        zplug "jhawthorn/fzy", \
                as:command, \
                rename-to:fzy, \
                hook-build:"make && sudo make install"

        # Supports checking out a specific branch/tag/commit
        zplug "b4b4r07/enhancd", at:v1
        zplug "mollifier/anyframe", at:4c23cb60

        # Can manage gist file just like other packages
        zplug "b4b4r07/79ee61f7c140c63d2786", \
                from:gist, \
                as:command, \
                use:get_last_pane_path.sh

        # Support bitbucket
        zplug "b4b4r07/hello_bitbucket", \
                from:bitbucket, \
                as:command, \
                use:"*.sh"

        # Rename a command with the string captured with `use` tag
        zplug "b4b4r07/httpstat", \
                as:command, \
                use:'(*).sh', \
                rename-to:'$1'

        # TODO: Group dependencies
        # Load "emoji-cli" if "jq" is installed in this example
        # zplug "stedolan/jq", \
        #       from:gh-r, \
        #       as:command, \
        #       rename-to:jq
        zplug "b4b4r07/emoji-cli", \
                on:"stedolan/jq"
        # Note: To specify the order in which packages should be loaded, use the defer
        #       tag described in the next section

        # Set the priority when loading
        # e.g., zsh-syntax-highlighting must be loaded
        # after executing compinit command and sourcing other plugins
        # (If the defer tag is given 2 or above, run after compinit command)
        zplug "zsh-users/zsh-syntax-highlighting", defer:2

        # Can manage local plugins
        # zplug "~/.zsh", from:local

        # Load theme file
        zplug 'dracula/zsh', as:theme

        # Load vim-visual mode to vi-mode of zsh
        zplug "b4b4r07/zsh-vimode-visual", defer:3

        # Friendly bindings for ZSH’s vi mode
        zplug softmoth/zsh-vim-mode

        # Install plugins if there are plugins that have not been installed
        if ! zplug check --verbose; then
                printf "Install? [y/N]: "
                if read -q; then
                        echo; zplug install
                fi
        fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="random"

# Then, source plugins and add commands to $PATH
zplug load --verbose

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# ======================================================
# My custom fuctions
# ======================================================
# md is to view markdown-formatted file
md() {
        fileName=${1:-"README.md"}
        mdp "$fileName"
}

# Load autojump plugin and u can type 'j' in the terminal for ease of use
[[ -s /usr/share/autojump/autojump.sh ]] && . /usr/share/autojump/autojump.sh

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


# ======================================================
# My old configuration that enable vimode and bind keys
# ======================================================
# Load configuration of oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Display current SHELL depth in zsh
PS1="[$(lvl)]$PS1"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

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

# Load fuzzy file finder plugin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
