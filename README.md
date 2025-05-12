# gptConfig.sh
## A bash script for running a DayZ server with mods using the Linux cli.

### This script was made by chatGPT and then further refined.
Portions of this guide are copied from the official BI wiki [link]

### Presumptions:  
You have a brand new, fresh install Ubuntu 22.04 system.  
Your system has at least two fast CPU cores, SSD storage and at least 8GB RAM.  
You are looking at a *root* or *ubuntu* login prompt.  

### Create a user for the server:

`sudo adduser dayzserver`

`sudo usermod -aG sudo dayzserver`

### Now log in as the *dayzserver* user and update the system

`sudo apt update`

`sudo apt upgrade`

### Install requirements:

`sudo apt-get install lib32gcc-s1`

### Prepare directories for *steamcmd*:

`mkdir -p ~/servers/steamcmd && cd ~/servers/steamcmd`

### Download and extract *steamcmd*:

`curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -`

### Ensure you are in ~/ (aka /home/dayzserver/):

`cd`

### Make a directory for your server scripts:

`mkdir scripts`

`cd scripts`

### Clone or download this repo:

`wget https://github.com/nutday5/scriptz/archive/refs/heads/main.zip`

`unzip main.zip`

`mv scriptz-main/* .`

### Make the script(s) executable:  

`chmod 0777 ./*.sh`

```
@possible-beagle:/home/dayzserver/scripts# ls -la
total 13
drwxrwxr-x 2 dayzserver dayzserver    8 May 11 18:11 .
drwxr-x--- 8 dayzserver dayzserver   15 May 12 09:16 ..
-rw-rw-r-- 1 dayzserver dayzserver  439 Jan 30 16:19 README.md
-rwxrwxrwx 1 dayzserver dayzserver 3230 May 11 18:11 gptConfig.sh
-rwxrwxrwx 1 dayzserver dayzserver  217 May 11 18:10 start.sh
-rw-rw-r-- 1 dayzserver dayzserver  206 May 11 17:59 steam_ids.txt
-rwxrwxrwx 1 dayzserver dayzserver 4005 May 11 18:06 update.sh
```

### Ensure you are in ~/ 

`cd`

### Edit *gptConfig.sh* to set your steam username:

`vi ./scripts/gptConfig.sh` Other text editors are available

### and change 

```
STEAMUSR="YOURNAME" #You
```

> escape, colon, w, q

### Edit *steam_ids.txt* to set your mods:

`vi ./scripts/steam_ids.txt`

### Now you can run *gptConfig.sh* to create your *start.sh* and *update.sh* files:

`./scripts/gptConfig.sh`

### Install the server and mods by running *update.sh*:

`./scripts/update.sh`

> steamcmd goes brrrr

### Create and install a *systemd* config:

`sudo vi /etc/systemd/system/dayz-server.service`

```
[Unit]
Description=DayZ Dedicated Server
Wants=network-online.target
After=syslog.target network.target nss-lookup.target network-online.target

[Service]
#ExecStartPre=/home/dayzserver/scripts/update.sh
ExecStart=/home/dayzserver/scripts/start.sh
WorkingDirectory=/home/dayzserver/servers/dayz-server/
LimitNOFILE=100000
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s INT $MAINPID
User=dayzserver
Group=users
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
```

`sudo systemctl daemon-reload`

### You can now control the server through *systemd*:

`sudo systemctl start dayz-server`   
`sudo systemctl stop dayz-server`  
`sudo systemctl status dayz-server`

### Once happy, you can have the server start at boot time
`sudo systemctl enable dayz-server`