#!/bin/bash

pacman -Syu sudo vi network-manager-applet alacritty sway sddm vim networkmanager wofi \
  swaylock swayidle swaybg fish autotiling-rs neovim thunar thunar-archive-plugin \
  thunar-media-tags-plugin thunar-vcs-plugin thunar-volman wl-clipboard otf-font-awesome \
  pavucontrol ttf-firacode-nerd pipewire-pulse pipewire-alsa wireplumber sof-firmware \
  noto-fonts-emoji nvidia-dkms linux-headers udisks2 gvfs waybar brightnessctl man-db \
  bluez bluez-utils blueman mpd sway-contrib nwg-look qt6-svg qt5-quickcontrols2 xarchiver \
  unzip papirus-icon-theme nodejs npm imv mpv mpv-mpris rclone yt-dlp libmtp gvfs-mtp \
  android-udev ripgrep swaync libreoffice imagemagick reflector zathura zathura-pdf-mupdf \
  zathura-cb zathura-djvu zathura-ps qt6-wayland qt5-wayland qt5ct qt6ct tmux dnsmasq \
  libvirt virt-manager qemu-full audacious wget pass pass-otp virt-viewer firewalld \
  gnome-keyring dosfstools nwg-displays kguiaddons zbar hyprland hyprcursor hyprgraphics \
  hyprland-protocols hyprland-qtutils hyprland-qt-support hyprlock hyprpaper hyprpicker \
  hyprpolkitagent hyprshot hyprsunset hyprutils hyprwayland-scanner hypridle tlp fail2ban

aurhelper=""
sudo pacman -S --needed git base-devel

echo -e "\n[STEP 2/3] Please select your preferred AUR Helper:"
echo "  1) Install 'yay' (Popular, Golang-based)"
echo "  2) Install 'paru' (Rust-based, inspired by yay)"
echo "  3) Cancel installation"
echo -n "Enter choice (1, 2, or 3): "
read CHOICE

case $CHOICE in
  1)
    aurhelper="yay"
    echo -e "\nSelected: $aurhelper. Starting installation..."
    REPO_NAME="yay"
    REPO_URL="https://aur.archlinux.org/$REPO_NAME.git"
    ;;
  2)
    aurhelper="paru"
    echo -e "\nSelected: $aurhelper. Starting installation..."
    REPO_NAME="paru"
    REPO_URL="https://aur.archlinux.org/$REPO_NAME.git"
    ;;
  3)
    echo -e "\nInstallation cancelled by user."
    exit 0
    ;;
  *)
    echo -e "\nInvalid choice. Installation cancelled."
    exit 1
    ;;
esac

cd /tmp
if git clone "$REPO_URL"; then
  echo "Repository cloned successfully."
else
  echo "Error: Failed to clone $REPO_NAME repository. Exiting."
  exit 1
fi

cd "$REPO_NAME"

if makepkg -si; then
    echo -e "\nSuccess! '$aurhelper' has been installed."
else
    echo -e "\nError! Failed to install '$aurhelper' using makepkg -si."
fi

cd ..
rm -rf "$REPO_NAME"

$aurhelper -Syu rclone-browser papirus-folders-git brave-bin yacreader pass-import wofi-pass

echo -e "\nAvailable Colors (Use these names for your selection):"
papirus-folders -l
echo -n "Enter the exact NAME of the color you want (e.g., magenta, blue, red): "
read SELECTED_COLOR

echo -e "\nSelect the theme variant:"
echo "  1) Papirus (Light/Default)"
echo "  2) Papirus-Dark"
echo -n "Enter choice (1 or 2): "
read THEME_CHOICE

if [ "$THEME_CHOICE" == "1" ]; then
    SELECTED_THEME="Papirus"
elif [ "$THEME_CHOICE" == "2" ]; then
    SELECTED_THEME="Papirus-Dark"
else
    SELECTED_THEME="Papirus-Dark"
    echo "Invalid choice. Defaulting to 'Papirus-Dark'."
fi

papirus-folders -C "$SELECTED_COLOR" --theme "$SELECTED_THEME"
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
