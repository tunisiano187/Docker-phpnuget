#!/bin/bash

## Use the User provided cert instead of running Let'sEncrypt
if test -f "/app/phpnuget/data/ssl/$SSLCRT"  && test -f "/app/phpnuget/data/ssl/$SSLKEY" ; then
    echo "$SSLCRT exists."
else
    if (! [ -z "$STAGING" ]) then
      echo "Using Let's Encrypt Staging environment..."
      certbot -n --staging --expand --apache --agree-tos --email $WEBMASTER_MAIL "$@"
    else
      echo "Using Let's Encrypt Production environment..."
      certbot -n --expand --apache --agree-tos --email $WEBMASTER_MAIL "$@"
    fi
fi

