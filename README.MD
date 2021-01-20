Host your own nuget feed with this docker image running phpnuget from kendar.org.

1. Git the Project to your local machine:

git clone https://github.com/MarkProminic/Docker-phpnuget.git

2. Enter the project Directory

3. Build the Project:

docker build -t myorganziation/phpnugetv4.1 .

4.  Start the container with:

docker run -d -p 80:80  -p 443:443 -e DOMAINS="chocolatey.my.domain.net" -e VHOST1="chocolatey.my.domain.net" -e WEBMASTER_MAIL="Me@my.domain.net" -e STAGE="false" -v /choco/:/app/phpnuget/data/ --dns 1.1.1.1 --name MyPHPNuGETV2 myorganziation/phpnugetv4.1

5. Point your web browser to http://\<yourhost\>/setup.php

6. Change settings and hit "Install".

Note:
Nb! Leave "Application Path:" as is (phpnuget)
Field "php-cgi.exe (for IIS):" could be emptied.

7. Login at http://\<yourhost\>

and start uploading packages.

Happy nugetting!
