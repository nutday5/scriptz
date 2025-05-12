#!/bin/bash

#######
# Configs builder for DayZ Dedicated Server
# v0.1.300524
# Input file format is steamid:descriptor (123456789:Modname)
#######

# 12/5/25 TODO: 
# Explain more about the switches
# Provide more example steam_ids.txt

####### Start your edits here ################
GAMEID="1042420" #Exp or Stable
WSGAME="221100" #Workshop game id
STEAMUSR="YOURNAME" #You
MODS="" #for local dev, inserts yourmod to start.sh
LIMITS="-limitFPS=60" #because yes
LC_PATH1="/home/dayzserver/servers/steamcmd/steamcmd.sh"
LC_PATH2="/home/dayzserver/servers/dayz-server/"
KY_PATH="/home/dayzserver/servers/dayz-server/keys/dayz.bikey"
LC_START="$LC_PATH1 +force_install_dir $LC_PATH2"
# Define input and output files
INPUT_FILE="/home/dayzserver/scripts/steam_ids.txt"
OUTPUT_FILE="/home/dayzserver/scripts/update.sh"
START_FILE="/home/dayzserver/scripts/start.sh"
####### Stop editing now ################


# Clear or create the output file
> "$OUTPUT_FILE"
> "$START_FILE"
#begin
MC_CMD=""
MC_CMD+="$LC_START +login $STEAMUSR +app_update $GAMEID "

# Check if the input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Input file not found!"
  exit 1
fi

# Function to validate Steam ID format
validate_steam_id() {
  local steam_id="$1"
  if [[ "$steam_id" =~ ^[0-9]{10}$ ]]; then
    return 0
  else
    return 1
  fi
}

# Read and process each Steam ID and text descriptor from the input file
while IFS=: read -r steam_id text_descriptor; do
  validate_steam_id "$steam_id"
  if [[ $? -eq 0 ]]; then
    echo "Mod: $steam_id ($text_descriptor)"
    MC_CMD+=" +workshop_download_item $WSGAME $steam_id "
    MODS+="$steam_id;"
  else
    echo "Invalid Steam ID: $steam_id"
  fi
done < "$INPUT_FILE"
MC_CMD+=" +quit"
echo -e "$MC_CMD" >> "$OUTPUT_FILE"

SL_CMD=""
# Read and process each Steam ID to rebuild symlinks
while IFS=: read -r steam_id text_descriptor; do
  validate_steam_id "$steam_id"
  if [[ $? -eq 0 ]]; then
    echo "Symlink: $steam_id ($text_descriptor)"
    SL_CMD+="rm /home/dayzserver/servers/dayz-server/$steam_id \n"
    SL_CMD+="ln -s /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/$steam_id ${LC_PATH2}${steam_id} \n"
  else
    echo "Invalid Steam ID: $steam_id"
  fi
done < "$INPUT_FILE"
echo -e "$SL_CMD" >> "$OUTPUT_FILE"

# handle keys
KY_CHG="cp $KY_PATH $LC_PATH2 \n"
echo -e "$KY_CHG" >> "$OUTPUT_FILE"
KY_CMD="rm -f ${LC_PATH2}keys/*.bikey \n"
echo -e  "$KY_CMD" >> "$OUTPUT_FILE"
KY_CHG="mv ${LC_PATH2}dayz.bikey $KY_PATH \n"
echo -e  "$KY_CHG" >> "$OUTPUT_FILE"

KY_CM2=""
# Read and process each Steam ID to rebuild keys
while IFS=: read -r steam_id text_descriptor; do
  validate_steam_id "$steam_id"
  if [[ $? -eq 0 ]]; then
    echo "Key: $steam_id ($text_descriptor)"
    KY_CM2+="ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/$steam_id/keys/*  ${LC_PATH2}keys/ \n"
    KY_CM2+="ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/$steam_id/Keys/*  ${LC_PATH2}keys/ \n"
    KY_CM2+="ln -sf /home/dayzserver/servers/dayz-server/steamapps/workshop/content/221100/$steam_id/KEYS/*  ${LC_PATH2}keys/ \n"
  else
    echo "Invalid Steam ID: $steam_id"
  fi
done < "$INPUT_FILE"

# write update.sh
echo -e "$KY_CM2" >> "$OUTPUT_FILE"
echo "server update script written to $OUTPUT_FILE"

# write start.bat ;)
echo -e "#!/bin/bash\n${LC_PATH2}DayZServer -config=serverDZ.cfg \"-mod=$MODS\" -bepath= -profiles=profiles $LIMITS" >> "$START_FILE"
#todo provide options for setting -dologs -adminlog -netlog -freezecheck
echo "server start script written to $START_FILE"