if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -U fish_greeting
fish_config prompt choose arrow
set -gx XDG_SCREENSHOTS_DIR ~/Pictures/Screenshots
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx QT_QPA_PLATFORMTHEME qt6ct
set -gx GPG_TTY $(tty)
set -gx TERMINAL /usr/bin/alacritty
set -gx TERM xterm-256color
set -gx LIBVIRT_DEFAULT_URI qemu:///system
if status is-interactive
and not set -q TMUX
    exec tmux
end
if test -d "$HOME/.local/bin"
    set -gx PATH "$HOME/.local/bin" $PATH
end
