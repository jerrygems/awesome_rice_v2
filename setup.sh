cd ~/
sudo apt update && sudo apt upgrade
sudo apt install git
# few tools to install and dependencies
sudo apt install make xinput rofi pulsemixer i3lock-fancy lm-sensors awesome lua5.2 luarocks picom btop feh brightnessctl cava playerctl alacritty neofetch python3-pyaudio liblua5.3-dev

sudo apt-get install build-essential cmake libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libxcb-cursor-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libglib2.0-dev libgdk-pixbuf2.0-dev libcairo2-dev libx11-dev libxcb-xtest0-dev libxcb-shape0-dev libxcb-xfixes0-dev libcairo2-dev libstartup-notification0-dev libxdg-basedir-dev libxcb-xrm-dev


# awesome window manager installation
sudo apt build-dep awesome
git clone https://github.com/awesomewm/awesome
cd awesome
sudo make package
cd build
sudo dpkg -i ./*.deb


cd ~/.config

mv ~/awesome_rice_v2 ~/.config/awesome
cd ~/.config/awesome/
mv ./Dots/fonts ~/.fonts
mv ./Dots/Mousepad ~/.config/
mv ./Dots/picom ~/.config/
mv ./Dots/rofi ~/.config/

git clone https://github.com/vicious-widgets/vicious.git -o vicious
mkdir lib
cd lib
git clone https://github.com/andOrlando/rubato.git -o rubato

sudo touch /usr/share/xsessions/awesome.desktop
sudo echo "[Desktop Entry]" >> /usr/share/xsessions/awesome.desktop
sudo echo "Type=Application" >> /usr/share/xsessions/awesome.desktop
sudo echo "Name=Awesome Window Manager" >> /usr/share/xsessions/awesome.desktop
sudo echo "Exec=awesome" >> /usr/share/xsessions/awesome.desktop
sudo echo "Terminal=false" >> /usr/share/xsessions/awesome.desktop



systemctl reboot -i
