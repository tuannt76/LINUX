#!/bin/bash

clear
printf "Gui tin toi group Telegram \n"
echo "nhap noi dung :"
read mes

token=5099434027:AAFetc-W1flprg_YbBc1kO4UIL_gpnaUWfg
id=-746592079
url=https://api.telegram.org/bot${token}/sendMessage

curl -d chat_id=$id -d text="$mes" $url

clear
printf "Gui $mes thanh cong\n"