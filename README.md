# Installation
**for setting up this rice**

### first of all follow the steps inside setup.sh or just run it after running the command below

```bash
    chmod +x setup.sh
    chmod +x service.sh
```
### at the end when you've completed these steps then setup a service for running for running the picom compositor on reboot so that you don't have to do that manually for that

```bash
    sudo nano /etc/systemd/system/picom.service
```
### and then paste the below content in it and change the username accordingly
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

### if the picom doesn't work with blue then please try restarting it with below commands or you can run the command manually in setup.sh or put an command in your .bashrc or .zshrc file

```bash
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

**for customizing things easily just look at congs/config.lua where you can find few variables and can change them accordingly otherwise keep messing with code Xd**
