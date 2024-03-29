#!/bin/bash
chown www-data:www-data /app -R
echo $VHOST1
#sed -i "s/_default_/$VHOST1/g" /etc/apache2/sites-available/default-ssl.conf
sed -i "s/ServerAdmin webmaster@localhost/ServerName $VHOST1/g" /etc/apache2/sites-available/default-ssl.conf
sed -i "s/ServerAdmin webmaster@localhost/ServerAlias $VHOST1/g" /etc/apache2/sites-available/default-ssl.conf

ln -sf /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi



if test -f "/app/phpnuget/ssl/$SSLCRT"  && test -f "/app/phpnuget/ssl/$SSLKEY" ; then
    sed -i "s/\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem/\/app\/phpnuget\/ssl\/$SSLCRT/g" /etc/apache2/sites-available/default-ssl.conf
    sed -i "s/\/etc\/ssl\/private\/ssl-cert-snakeoil.key/\/app\/phpnuget\/ssl\/$SSLKEY/g" /etc/apache2/sites-available/default-ssl.conf
else
    /run_letsencrypt.sh --domains $DOMAINS
    sed -i "s/\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem/\/etc\/letsencrypt\/live\/$VHOST1\/fullchain.pem/g" /etc/apache2/sites-available/default-ssl.conf
    sed -i "s/\/etc\/ssl\/private\/ssl-cert-snakeoil.key/\/etc\/letsencrypt/live\/$VHOST1\/privkey.pem/g" /etc/apache2/sites-available/default-ssl.conf
fi

service apache2 stop

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND

