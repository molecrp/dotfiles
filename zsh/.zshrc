#############################
###        OPTIONS        ###
#############################
setopt share_history
# for capital-case autocompletion
autoload -Uz compinit && compinit

# slash backward-kill-word
autoload -U select-word-style
select-word-style bash

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# prevent from closing on Ctrl+d
setopt ignore_eof


#############################
###       VARIABLES       ###
#############################
# main
  export ZDOTDIR='/home/spil/home/.config/zsh'
  export EDITOR='/usr/bin/nvim'
  export MANPAGER="nvim +Man!"
  export HISTFILE="/home/spil/home/.config/zsh/zsh_history"

# pass
  export PASSWORD_STORE_DIR="/home/spil/main/documents/personal/pass"
  export GNUPGHOME="/home/spil/main/documents/personal/gnupg"

# themes
  export GTK_THEME=Adwaita-dark

# complementary
  export QT_STYLE_OVERRIDE="adwaita-dark"
  
# libvirt / qemu
  export LIBVIRT_DEFAULT_URI=qemu:///system

# LSP
  export GEM_HOME="/home/spil/home/.local/share/gem/ruby/3.1.0/gems"
  export PATH=$PATH:/home/spil/home/.local/share/nvim/mason/bin/

# XDG
  export XDG_CONFIG_HOME="/home/spil/home/.config"
  export XDG_CACHE_HOME="/home/spil/home/.cache"
  export XDG_DATA_HOME="/home/spil/home/.local/share"
  export XDG_STATE_HOME="/home/spil/home/.local/state"
  export XDG_CONFIG_HOME="/home/spil/home/.config"

# style
  export MINIKUBE_IN_STYLE=false


#############################
###        PROMPT         ###
#############################
# Execution sequence (/etc, /~) 1) zshenv 2) zprofile (login) 3) zshrc (interactive) 4) zlogin (login)
# PROMPT='%B%F{6}%n@%m%f%b %F{3}%~%f %F{9}[%?]%f > ' # One line prompt
PROMPT='
╭──%F{6}(%n@%m)%f %F{3}[%~]%f %F{9}{%?}%f %F{11}$(git_super_status)%f
╰─❱ '


#############################
###        ALIASES        ###
#############################
# cross-dev
  alias wing++="/usr/lib/mingw64-toolchain/bin/x86_64-w64-mingw32-c++"
  alias winobjdump='/usr/lib/mingw64-toolchain/bin/x86_64-w64-mingw32-objdump'

# func
  alias ll="ls -lhtrZ --color=always"
  alias la='ls -lahtrZ --color=always'
  alias dir='dir -al'
  alias cls='clear'
  alias srcz='source $ZDOTDIR/.zshrc'
  alias sudo='sudo -E'

# Looks
	alias grep='grep --color=auto'
	alias ip='ip --color=auto'
  alias btw='fastfetch'
  # alias feh='feh --image-bg "#282828"'
  alias display-colors='for i in {1..256}; do print -P "%F{$i}Color : $i"; done;'
  alias fucking='sudo -E'

# LDAP
  alias olsw='/home/spil/main/documents/projects/private/scripts/olsw'
  alias olswconf='export LDAPRC="/home/spil/home/.config/openldap/ldaprc_config"'
  alias olswroot='export LDAPRC="/home/spil/home/.config/openldap/ldaprc_mdb-1_rootdn"'

# pass
  alias passp="export PASSWORD_STORE_DIR=/mnt/sda1/main/documents/personal/ssv"
  alias passr="export PASSWORD_STORE_DIR=/home/spil/main/documents/personal/pass"



#############################
###         PATH          ###
#############################
export PATH=$PATH:/home/spil/home/.config/fastfetch
export PATH=$PATH:/home/spil/home/Applications/rubymine/RubyMine-2021.1.3/bin
export PATH=$PATH:/home/spil/main/documents/projects/private/scripts
export PATH="$(ruby -e 'puts Gem.user_dir')/gems/bin/:$PATH"
export PATH=$PATH:/home/spil/home/bin
export PATH="$PATH:/home/spil/home/.dotnet/tools"


#############################
###        KEYMAP         ###
#############################
# use man zshzle for reference on commands
# use cat to get keycodes
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
bindkey '^[^L' forward-char
bindkey '^[^H' backward-char


#############################
###        PLUGINS        ###
#############################
source /home/spil/home/.config/zsh/zsh-git-prompt/zshrc.sh
source /usr/share/zsh/scripts/antigen/antigen.zsh

antigen bundle jeffreytse/zsh-vi-mode
zvm_config() {
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
  ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
  ZVM_VI_HIGHLIGHT_FOREGROUND=#282828 
  ZVM_VI_HIGHLIGHT_BACKGROUND=#e78a4e
}

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle Aloxaf/fzf-tab

antigen apply
