Host your own nuget feed with this docker image running phpnuget from kendar.org.

Start: docker run -d -p 80:80 --name phpnuget tunisiano187/phpnuget

Point your web browser to http://\<yourhost\>/setup.php

Change settings and hit "Install".
Nb! Leave "Application Path:" as is (phpnuget)
Field "php-cgi.exe (for IIS):" could be emptied.

Login at http://\<yourhost\>

and start uploading packages.

Happy nugetting!
