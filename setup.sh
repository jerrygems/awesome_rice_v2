cd ~/
sudo apt update &&s sudo apt upgrade
sudo apt install git
# few tools to install and dependencies
sudo apt install xinput rofi pulsemixer i3lock-fancy lm-sensors awesome lua5.2 luarocks picom btop feh brightnessctl cava playerctl alacritty neofetch python3-pyaudio xcb-fixes xcb-randr liblua5.3-dev


# awesome window manager installation
git clone https://github.com/awesomeWM/awesome.git
cd awesome
make
sudo make install


cd ~/.config
git clone https://github.com/jerrygems/awesome_rice_v2.git
mv awesome_rice_v2 awesome
cd ~/.config/awesome/
mv ./Dots/fonts ~/.fonts
git clone https://github.com/vicious-widgets/vicious.git -o vicious
mkdir lib
cd lib
git clone https://github.com/andOrlando/rubato.git -o rubato

touch ~/.local/share/applications/awesome.desktop
echo "[Desktop Entry]" >> ~/.local/share/applications/awesome.desktop
echo "Type=Application" >> ~/.local/share/applications/awesome.desktop
echo "Name=Awesome Window Manager" >> ~/.local/share/applications/awesome.desktop
echo "Exec=awesome" >> ~/.local/share/applications/awesome.desktop
echo "Terminal=false" >> ~/.local/share/applications/awesome.desktop

systemctl reboot
