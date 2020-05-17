# History
# =======
HISTFILE=$XDG_CONFIG_HOME/zsh/.zsh_history
SAVEHIST=20000
HISTSIZE=$SAVEHIST
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt append_history
setopt share_history

# Aliases and functions
# =====================
h() { if [[ -z $@ ]]; then history 1; else history 1 | grep -E $@; fi; }
# zshaddhistory() { hash "${(Q)${(z)1}[1]}" &>/dev/null } # Don't add non-successful commands to history
alias ls="ls -lAhFX --group-directories --color=auto"
export LS_COLORS="rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:"
alias grep="grep --color=auto"
alias um="udiskie-umount -d"
alias hotspot="sudo create_ap wlp3s0 enp2s0 'Loading...' 'forsecurityreasons'"
pb () { curl -F "c=@${1:--}" https://ptpb.pw/ }
# alias pia="su -c 'cd /home/germain/Downloads/pia; openvpn --config Switzerland.ovpn'"
alias undervolt="su -c 'modprobe msr; wrmsr 0x150 0x80000011F9A00000; wrmsr 0x150 0x80000111F9A00000; wrmsr 0x150 0x80000211F9A00000'"
brightness() { echo $@ | sudo tee /sys/class/backlight/acpi_video0/brightness }
adbgrep() { adb logcat -c && adb logcat -v color | grep --color=never $@}
adbgrepcompat() { adb logcat | grep --color=never $@}
feralget() { wget -r --cut-dirs=3 -nH -np -e robots=off -R 'index.html*' $@ }
maxperf() { echo "$@" | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct }
noturbo() { echo "$@" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo }
alias acrobat="wine '/home/germain/.wine/drive_c/Program Files (x86)/Adobe/Acrobat Reader DC/Reader/AcroRd32.exe'"
alias epfl-jupyter="cd ~/Documents/uni/EPFL/ && unset BROWSER && jupyter notebook"
alias aurremove="repo-remove /var/cache/pacman/custom/custom.db.tar"
aur-devel() {
    aurvcs="(-git|-hg)$"
    aur sync "$(aur repo --list | cut -f1 | grep -E "$aurvcs" | tr '\n' ' ')" --no-ver --print
    aur sync --no-ver-shallow "$(aur vercmp-devel | cut -d: -f1 | tr '\n' ' ')"
}
webpandoc() { pandoc -s -r html "$1" -o "$2" }
alias epfl-conda-dis="[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh && conda activate dis2019"
alias epfl-conda-exam="[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh && conda activate dis_exam"
alias miniconda-activate="[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh"
upload() { curl -F file=@$1 'https://0x0.st' }
720p() { ffmpeg -i "$1" -vf scale=-1:720 -c:v libx265 -crf 24 -c:a aac -b:a 128k -scodec copy "$2" }

# Word selection
# ==============
autoload -U select-word-style
select-word-style bash

# Key bindings
# ============
# vi mode is weird for the shell, we use edit-command-line when needed
bindkey -e

# Partial searches
# ----------------
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Make some keys behave as expected
# ---------------------------------
bindkey "^[[H" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[Z" reverse-menu-complete

# History expansion
# -----------------
bindkey " " magic-space

# Edit command line
# -----------------
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

# Coloured manuals
# ================
autoload -U colors zsh/terminfo
colors

man() {
  env \
    LESS_TERMCAP_mb=$(print -P "%B%F{1}") \
    LESS_TERMCAP_md=$(print -P "%B%F{1}") \
    LESS_TERMCAP_me=$(print -P "%b") \
    LESS_TERMCAP_se=$(print -P "%b") \
    LESS_TERMCAP_so=$(print -P "%B%K{4}%F{3}") \
    LESS_TERMCAP_ue=$(print -P "%b") \
    LESS_TERMCAP_us=$(print -P "%B%F{2}") \
    man "$@"
}

# Completion
# ==========
zmodload zsh/complist
_zpcompinit_custom() {
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcd=${ZDOTDIR:-$HOME}/.zcompdump
  local zcdc="$zcd.zwc"
  if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
        compinit -C -d "$zcd"
        { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}
_zpcompinit_custom
unsetopt menu_complete # do not autoselect the first completion entry
zstyle :compinstall filename "${XDG_CONFIG_HOME}/zsh/.zshrc"
zstyle ":completion:*" menu select
zstyle ":completion:*:pacman:*" force-list always
zstyle ":completion:*:*:pacman:*" menu yes select
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*:*:kill:*" menu yes select
zstyle ":completion:*:kill:*"   force-list always
zstyle ":completion:*:*:killall:*" menu yes select
zstyle ":completion:*:killall:*"   force-list always

# Window title
# ============
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
        print -Pn "\e]0;%~ %#\a\a"
    }
    preexec () {
        print -Pn "\e]0;%~ %# " && print -n -- "${(q)1}\a"
    }
    ;;
  screen|screen-256color)
    precmd () {
        print -Pn "\e]83;title \"${~1:gs/%/%%}\"\a"
        print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
    }
    preexec () {
        print -Pn "\e]83;title \"${~1:gs/%/%%}\"\a"
        print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] (" && print -n -- "${~1:gs/%/%%})\a"
    }
    ;;
esac


# Prompt
# ======
rsegf=""
branch=""
action="⚡"
dirty="•"

setopt prompt_subst
autoload -Uz vcs_info
zstyle ":vcs_info:*" actionformats "%F{239}%s $branch %b $action %a"
zstyle ":vcs_info:*" formats "%F{239}%s $branch %b"
zstyle ":vcs_info:(sv[nk]|bzr):*" branchformat "%b%F{2}:%F{1}%r"
zstyle ":vcs_info:*" enable git cvs svn hg bzr

vcs_info_wrapper() {
    vcs_info
    if [[ -n $vcs_info_msg_0_ ]]; then
        git_status=$(command git status -s 2> /dev/null)
        print -n "%K{172}%F{154}$rsegf%f%k%K{172} %F{0}${vcs_info_msg_0_}"
        if [[ -n $git_status ]]; then
            print -n " $dirty"
        fi
        print "%f %k%F{172}$rsegf%f"
    else
        print "%F{154}$rsegf%f%}"
    fi
}

vcsinfo=$'$(vcs_info_wrapper)'
setprompt () {
    if [[ $TTY == /dev/tty* ]]; then
        PROMPT="%n@%m %~ %# "
    else
        PROMPT="%K{239}%F{255} %n@%m %k%K{154}%F{239}$rsegf%k%K{154} %F{239}%~ %k$vcsinfo
%(!.%K{green} #.%K{blue} %%) %k%(!.%F{red}.%F{blue})$rsegf%f "
    fi
}
setprompt

# Other
# =====

# ulimit
# ------
ulimit -c unlimited

# Envoy
# -----
#envoy -t ssh-agent id_rsa
#source <(envoy -p)

## Autologin
## ---------
#if [[ $(tty) == "/dev/tty1" ]]; then
#    if [[ ! -f "/tmp/startedx" ]]; then
#        touch /tmp/startedx
#        if [[ $(lspci | grep 'VGA.*NVIDIA') ]]; then
#            echo 'eGPU detected, starting nvidia-xrun'
#            exec nvidia-xrun &> /dev/null
#        else
#            exec sx &> /dev/null
#        fi
#    fi
#fi

# Code from Mikael Magnusson: http://www.zsh.org/mla/users/2011/msg00367.html
#
# Requires xterm, urxvt, iTerm2 or any other terminal that supports bracketed
# paste mode as documented: http://www.xfree86.org/current/ctlseqs.html

# create a new keymap to use while pasting
bindkey -N paste
# make everything in this keymap call our custom widget
bindkey -R -M paste "^@"-"\M-^?" paste-insert
# these are the codes sent around the pasted text in bracketed
# paste mode.
# do the first one with both -M viins and -M vicmd in vi mode
bindkey '^[[200~' _start_paste
bindkey -M paste '^[[201~' _end_paste
# insert newlines rather than carriage returns when pasting newlines
bindkey -M paste -s '^M' '^J'

zle -N _start_paste
zle -N _end_paste
zle -N zle-line-init _zle_line_init
zle -N zle-line-finish _zle_line_finish
zle -N paste-insert _paste_insert

# switch the active keymap to paste mode
function _start_paste() {
  bindkey -A paste main
}

# go back to our normal keymap, and insert all the pasted text in the
# command line. this has the nice effect of making the whole paste be
# a single undo/redo event.
function _end_paste() {
#use bindkey -v here with vi mode probably. maybe you want to track
#if you were in ins or cmd mode and restore the right one.
  bindkey -e
  LBUFFER+=$_paste_content
  unset _paste_content
}

function _paste_insert() {
  _paste_content+=$KEYS
}

function _zle_line_init() {
  # Tell terminal to send escape codes around pastes.
  [[ $TERM == rxvt-unicode || $TERM == xterm || $TERM = xterm-256color || $TERM = screen || $TERM = screen-256color ]] && printf '\e[?2004h'
}

function _zle_line_finish() {
  # Tell it to stop when we leave zle, so pasting in other programs
  # doesn't get the ^[[200~ codes around the pasted text.
  [[ $TERM == rxvt-unicode || $TERM == xterm || $TERM = xterm-256color || $TERM = screen || $TERM = screen-256color ]] && printf '\e[?2004l'
}

# Plugins
# -------
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

