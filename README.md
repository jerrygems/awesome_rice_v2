# Installation
**for setting up this rice**
### before installing it make sure you're using debian distro cuz this is only tested on debian distro on other distros to make it work you'll have to mess with it
**;-)**
### Follow these steps

```bash
    git clone https://github.com/jerrygems/awesome_rice_v2.git
    cd awesome_rice_v2
    chmod +x setup.sh
    chmod +x service.sh
```
### and you'll have to create a picom.service to start the picom itself on every restart and paste the below content in that
**do not forget to put your username in the file "{enter your username}"**
```
[Unit]
Description=Picom X compositor

[Service]
ExecStart=bash /home/{enter your username}/.config/awesome/service.sh
Environment="DISPLAY=:0"
Restart=always
User=spidey

[Install]
WantedBy=multi-user.target
```

### after setting the picom.server you'll have to run below commands

```
sudo systemctl enable picom.service
sudo systemctl restart picom.service
```
### and all the default keybindings are here 

| Combinations           | Functionalities                                                     |
| ---------------------- | ------------------------------------------------------------------- |
| Mod+Left               | view previous screen                                                |
| Mod+Right              | view next screen                                                    |
| Mod+Escape             | toggle between previous and present screen                          |
| Mod+Tab                | toggle between previous and present client                          |
| Mod+Return             | spawn a terminal                                                    |
| Mod+Shift+q            | quit awesome                                                        |
| Mod+Shift+r            | reload awesome                                                      |
| Mod+t                  | change window arrangement or layout                                 |
| Mod+]                  | unminimize client                                                   |
| Mod+[                  | minimize client                                                     |
| Mod+r                  | spawing prompt that will not be visible(esc for exiting from there) |
| Mod+d                  | show rofi drun menu                                                 |
| Mod+w                  | show rofi window menu                                               |
| Mod+x                  | toggle visiblity of shutdown options                                |
| Mod+h                  | seek 10 sec backward                                                |
| Mod+j                  | play previous audio or video                                        |
| Mod+k                  | Play&Pause                                                          |
| Mod+l                  | Play next audio or video                                            |
| Mod+;                  | seek 10 sec forward                                                 |
| Mod+Shift+Up           | raise volume by 10                                                  |
| Mod+Shift+Down         | decrease volume by 10                                               |
| Mod+f                  | set client to full screen                                           |
| Mod+Shift+c            | to close the client                                                 |
| Mod+`                  | set client always on top                                            |
| Mod+m                  | toggle maximize client size                                         |
| Mod+Shift+v            | toggle maximize client vertically                                   |
| Mod+Shift+h            | toggle maximize client horizontally                                 |
| Mod+n {n -> 1..9}      | goto specific screen number                                         |
| Mod+Shift+n {n-> 1..9} | move client to specific screen number                               |
| Mod+Ctrl+n             | focus on multiple screens                                           |
| Mod+b                  | toggle three bars ( bottom, left, right )                           |
| Mod+Shift+b            | toggle top bar                                                      |

**for customizing things easily just look at confs/config.lua where you can find few variables and can change them accordingly otherwise keep messing with code Xd**
