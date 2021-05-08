Host your own nuget feed with this docker image running phpnuget from kendar.org.

1. Git the Project to your local machine:
```
git clone https://github.com/MarkProminic/Docker-phpnuget.git
```
2. Enter the project Directory
```
cd Docker-phpnuget
```
3. Build the Project:
```
docker build -t myorganziation/phpnugetv4.1 .
```
4.  Start the container with:
```
docker run -d -p 80:80  -p 443:443 -e DOMAINS="chocolatey.my.domain.net" -e VHOST1="chocolatey.my.domain.net" -e WEBMASTER_MAIL="Me@my.domain.net" -e STAGING="false" -v /choco/:/app/phpnuget/data/ --dns 1.1.1.1 --name MyPHPNuGETV2 myorganziation/phpnugetv4.1
```

If you want to use your own SSL cert and key, then you need to place them inside the path that you have mounted as the data store. in the Above example it would be  /choco 

Naming your files privkey.pem and fullchain.pem  will allow you to run the container without specifying the environmental variables. If you need to specify the names, use the Environmental variabels as decribed below.

```
docker run -d -p 80:80  -p 443:443 -e DOMAINS="chocolatey.my.domain.net" -e VHOST1="chocolatey.my.domain.net" -e WEBMASTER_MAIL="Me@my.domain.net" -e STAGING="false" -v /choco/:/app/phpnuget/data/ -e SSLCRT=fullchain.pem -e SSLCRT=privkey.pem --dns 1.1.1.1 --name MyPHPNuGETV2 myorganziation/phpnugetv4.1
```

During the first few minutes the site will load a temporary SSL while Let's Encrypt Fetches a live certifcate. Simply refresh the page after a few minutes to see an updated cert.

If you need to store large static files you can mount a host path as follows:

```
docker run -d -p 80:80  -p 443:443  -v /static/:/app/static/  -e DOMAINS="chocolatey.my.domain.net" -e VHOST1="chocolatey.my.domain.net" -e WEBMASTER_MAIL="Me@my.domain.net" -e STAGING="false" -v /choco/:/app/phpnuget/data/ -e SSLCRT=fullchain.pem -e SSLCRT=privkey.pem --dns 1.1.1.1 --name MyPHPNuGETV2 myorganziation/phpnugetv4.1
```

Where /static is a path on the host and /app is symlinked to /var/www/html in the container.


Environmental Variables:

| Varible  | Value |
| ------------- | ------------- |
| VHOST1 | This is to specify which virutalhost the SSL should be applied to. |
| DOMAINS | This is to specify all the domains that should be issued. |
| STAGING | Supposed to only pull staging certifcates. |
| WEBMASTER_MAIL | Is a required field for Let's Encrypt. |
| SSLCRT | file name of a PEM formatted SSL CERT to use in lieu of Let's Encrypt, if using the /choco directory above, then place it inside of that folder |
| SSLKEY | file name of a PEM formatted SSL KEY to use in lieu of Let's Encrypt, if using the /choco directory above, then place it inside of that folder |


5. Point your web browser to http://\<yourhost\>/setup.php

6. Change settings and hit "Install".


| Notes |  |
| ------------- | ------------- |
| Nb! Leave "Application Path:" | as is (phpnuget) |
| Field "php-cgi.exe (for IIS):" | could be emptied. |
 
7. Login at http://\<yourhost\> and start uploading packages.

Happy nugetting!

Credit where due:

Base Dockerfile Idea: https://github.com/tunisiano187/Docker-phpnuget

Let'sEncrypt on Apache inside of Docker: https://github.com/BirgerK/docker-apache-letsencrypt
