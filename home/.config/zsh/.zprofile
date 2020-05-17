# export PATH=$HOME/.local/bin:$PATH
# 
# # XDG
# # ===
# # export XDG_CACHE_HOME=$HOME/.cache
# # export XDG_CONFIG_HOME=$HOME/.config
# # export XDG_DATA_HOME=$HOME/.local/share
# 
# # Default config/cache locations
# # ==============================
# export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# export GIMP2_DIRECTORY=$XDG_CONFIG_HOME/gimp
# export XCOMPOSEFILE=$XDG_CONFIG_HOME/X11/xcompose
# export XINITRC=$XDG_CONFIG_HOME/X11/xinitrc
# export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/settings.ini
# export XAUTHORITY=$XDG_RUNTIME_DIR/X11-authority
# export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/config"
# export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
# export R_LIBS_USER=$XDG_DATA_HOME/R/
# export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat
# export PYLINTHOME=$XDG_CONFIG_HOME/pylint
# export LESSHISTFILE=$XDG_CACHE_HOME/lesshist
# 
# # Theming
# # =======
# export QT_STYLE_OVERRIDE=kvantum
# 
# # Programs
# # ========
# export EDITOR=nvim
# export DIFFPROG="nvim -d"
# export BROWSER=firefox
# export TERMINAL=kitty
# export TERMCMD=kitty
# export PAGER="less"
# 
# # Program options
# # ===============
# export PYTHONDONTWRITEBYTECODE=true
# export LESS=RS
# export NVIM_TUI_ENABLE_TRUE_COLOR=1
# export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
# export _JAVA_AWT_WM_NONREPARENTING=1
# export CALIBRE_USE_SYSTEM_THEME=1
# export SPARK_HOME=/opt/apache-spark
# export AUR_PAGER=ranger
# export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
# 
# Autologin
# ---------
if [[ $(tty) == "/dev/tty1" ]]; then
    if [[ ! -f "/tmp/startedx_tty1" ]]; then
        touch /tmp/startedx_tty1
        exec sx &> /dev/null
    fi
fi
if [[ $(tty) == "/dev/tty2" ]]; then
    if [[ ! -f "/tmp/startedx_tty2" ]]; then
        if [[ $(lspci | grep 'VGA.*NVIDIA') ]]; then
            touch /tmp/startedx_tty2
            echo -n 'eGPU detected, start nvidia-xrun? [y/N] '
            if [[ $(read -rqe) == "y" ]]; then
                exec nvidia-xrun &> /dev/null
            fi
        fi
    fi
fi
