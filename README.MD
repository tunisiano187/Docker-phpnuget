Host your own nuget feed with this docker image running phpnuget from kendar.org.

1. Git the Project to your local machine:
```
git clone https://github.com/tunisiano187/Docker-phpnuget.git
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

During the first few minutes the site will load a temporary SSL while Let'sEncrypt Fetches a live certifcate. Simply refresh the page after a few minutes to see an updated cert.

Environmental Variables:

| Varible  | Value |
| ------------- | ------------- |
| VHOST1 | This is to specify which virutalhost the SSL should be applied to. |
| DOMAINS | This is to specify all the domains that should be issued. |
| STAGING | May Not work, I think due a variable type, attempted fix this version, but is supposed to only pull staging certifcates. |
| WEBMASTER_MAIL | Is a required field for Let's Encrypt. |

5. Point your web browser to http://\<yourhost\>/setup.php

6. Change settings and hit "Install".


| Notes |  |
| ------------- | ------------- |
| Nb! Leave "Application Path:" | as is (phpnuget) |
| Field "php-cgi.exe (for IIS):" | could be emptied. |
 
7. Login at http://\<yourhost\> and start uploading packages.

Happy nugetting!

Credit where due:

Project updated by: MarkProminic

Let'sEncrypt on Apache inside of Docker: https://github.com/BirgerK/docker-apache-letsencrypt
