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