/home/dayzserver/servers/steamcmd/steamcmd.sh +force_install_dir /home/dayzserver/servers/dayz-server/ +login YOURNAME +app_update 1042420  +workshop_download_item 221100 1559212036  +workshop_download_item 221100 2545327648  +workshop_download_item 221100 1828439124  +workshop_download_item 221100 2291785308  +workshop_download_item 221100 2116157322  +workshop_download_item 221100 2291785437  +workshop_download_item 221100 2793893086  +quit
rm /home/dayzserver/servers/dayz-server/1559212036 
ln -s /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/1559212036 /home/dayzserver/servers/dayz-server/1559212036 
rm /home/dayzserver/servers/dayz-server/2545327648 
ln -s /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2545327648 /home/dayzserver/servers/dayz-server/2545327648 
rm /home/dayzserver/servers/dayz-server/1828439124 
ln -s /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/1828439124 /home/dayzserver/servers/dayz-server/1828439124 
rm /home/dayzserver/servers/dayz-server/2291785308 
ln -s /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2291785308 /home/dayzserver/servers/dayz-server/2291785308 
rm /home/dayzserver/servers/dayz-server/2116157322 
ln -s /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2116157322 /home/dayzserver/servers/dayz-server/2116157322 
rm /home/dayzserver/servers/dayz-server/2291785437 
ln -s /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2291785437 /home/dayzserver/servers/dayz-server/2291785437 
rm /home/dayzserver/servers/dayz-server/2793893086 
ln -s /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2793893086 /home/dayzserver/servers/dayz-server/2793893086 

cp /home/dayzserver/servers/dayz-server/keys/dayz.bikey /home/dayzserver/servers/dayz-server/ 

rm -f /home/dayzserver/servers/dayz-server/keys/*.bikey 

mv /home/dayzserver/servers/dayz-server/dayz.bikey /home/dayzserver/servers/dayz-server/keys/dayz.bikey 

ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/1559212036/keys/*  /home/dayzserver/servers/dayz-server/keys/ 
ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2545327648/keys/*  /home/dayzserver/servers/dayz-server/keys/ 
ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/1828439124/keys/*  /home/dayzserver/servers/dayz-server/keys/ 
ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2291785308/keys/*  /home/dayzserver/servers/dayz-server/keys/ 
ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2116157322/keys/*  /home/dayzserver/servers/dayz-server/keys/ 
ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2291785437/keys/*  /home/dayzserver/servers/dayz-server/keys/ 
ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/2793893086/keys/*  /home/dayzserver/servers/dayz-server/keys/ 

