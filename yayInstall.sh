sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S rclone-browser papirus-folders-git catppuccin-gtk-theme-macchiato brave-bin yacreader pass-import wofi-pass
papirus-folders -C magenta --theme Papirus-Dark
