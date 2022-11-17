#!/bin/bash
# Usage: ./checker.sh 14rb2UcfS9U89QmKswpZpjRCUVCVu1haSyqyGY486EvsYtvdJmR "SyncroB.it" user@gmail.com

cd /path/to/script # Replace with absolute path to the script, otherwise may cause issues with cron
maker_id=$1
maker_name=$2
mail_to=$3
mail_name=$(echo "$mail_to" | cut -d '@' -f1)
sent_file=$maker_name.$mail_name.sent_mail
cur_file=cur.$maker_name.$mail_name.json

api_result=$(curl -s -o /dev/null -I -w "%{http_code}" https://api.helium.io/v1/accounts/"$maker_id")
if [ "$api_result" -eq 200 ]; then
  if [ "$(curl -s https://api.helium.io/v1/accounts/"$maker_id" > "$cur_file")" -eq 0 ]; then
    dc_balance=$(jq .data.dc_balance "$cur_file")
    onboards_remain=$((dc_balance / 5000000))
    if [ $onboards_remain -gt 0 ]; then
          if [ ! -f "$sent_file" ]; then
                echo "Subject: Heads up! $maker_name has some onboards remaining!" > mail."$mail_name".txt
                echo "$maker_name has $onboards_remain onboards remaining. Get to it!" >> mail."$mail_name".txt
                if [ -n "$mail_to" ]; then
                        if [ "$(sendmail "$mail_to" < mail."$mail_name".txt)" -ne 0 ]; then
                                echo "Failed to send mail to $mail_to"
                        else
                                touch "$sent_file"
                        fi
                fi
          fi
    else
        rm -f "$sent_file"
    fi
fi
