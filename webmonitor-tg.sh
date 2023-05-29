#run this script with a specific cronjob!

#run before a wget of the site of your interest

#telegram notification variables
TELEGRAM_BOT_TOKEN="" #insert telegram bot tokern
urlbot="" #insert chat url of the bot
chat_id="" #insert the target chat id (the chat where the bot will send the message)

####################

site="www.site.com" #insert the site you want to check

wget -O change $site -P /path

var=$(diff /path/index /path/change)

if [ -z "$var"]; then #check if there are any differences on the site page
  echo "No differences..";
  curl -X POST \
   -H 'Content-Type: application/json' \
   -d '{"chat_id": '"$chat_id"', "text": "'"$site"' site not modified...", "disable_notification": true}' \
   $urlbot
  exit 1;
else
  echo "Differences!";
  curl -X POST \
   -H 'Content-Type: application/json' \
   -d '{"chat_id": '"$chat_id"', "text": "'"$site"' Site updated!", "disable_notification": false}' \
   $urlbot
fi
