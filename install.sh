pacstrap -K /mnt base linux linux-headers linux-lts linux-lts-headers\
	intel-ucode nvidia-open-dkms nvidia-utils networkmanager vim\
	sof-firmware man-db man-pages efibootmgr
pacman -Syu terminus-font sbctl sudo vi git base-devel fish
	python-gobject power-profiles-daemon autotiling thunar\
	brightnessctl playerctl wofi alacritty firefox sway\
	wl-clipboard waybar autotiling thunar network-manager-applet\
	bluez bluez-utils blueman pipewire-pulse pipewire-alsa mako\
	pavucontrol keyd noto-fonts noto-fonts-cjk noto-fonts-emoji\
	unzip wget adw-gtk-theme gnome-themes-extra kvantum-qt5\
	qt5-wayland qt6-wayland qt5ct qt6ct nwg-look papirus-icon-theme\
	gnome-keyring gvfs udisks2 thunar-volman xorg-xwayland swaybg\
	mpv sway-contrib speech-dispatcher nwg-displays zathura\
	texlive-meta xdg-user-dirs virt-manager libvirt dnsmasq\
	iptables-nft dmidecode qemu-full imagemagick rtkit zathura\
	zathura-pdf-mupdf zathura-djvu zathura-ps zathura-cb\
	intel-media-driver libva-utils swtpm edk2-ovmf
yay -Syu envycontrol otf-font-awesome rclone-browser arc-gtk-theme\
	adwaita-qt5 adwaita-qt6 kvantum catppuccin-cursors-frappe\
	catppuccin-cursors-latte catppuccin-cursors-macchiato\
	catppuccin-cursors-mocha papirus-folders wofi-pass\
	tela-circle-icon-theme-all scid piper-tts-bin pass-import\
	piper-voices-en-us greetd-tuigreet bibata-cursor-theme-bin\
	greetd wl-screenrec
