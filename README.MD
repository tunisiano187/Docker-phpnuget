Host your own nuget feed with this docker image running phpnuget from kendar.org.

Start: docker run -d -p 80:80 --name phpnuget bwaller/phpnuget

Point your web browser to http://\<yourhost\>/phpnuget/setup.php

Change settings and hit "Install".
Nb! Leave "Application Path:" as is (phpnuget)
Field "php-cgi.exe (for IIS):" could be emptied.

Login at http://\<yourhost\>/phpnuget/

and start uploading packages.

Happy nugetting!