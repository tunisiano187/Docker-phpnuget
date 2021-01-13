FROM ubuntu:latest
MAINTAINER Fabian Clerbois fabian@bowlman.org 
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y apache2 \
                       php \
                       php-cli \
                       php-mysql \
                       mariadb-server \
                       wget \
                       zip
RUN a2enmod rewrite && service apache2 restart
RUN wget https://www.kendar.org/?p=/dotnet/phpnuget/phpnuget.zip -O phpnuget.zip
RUN unzip phpnuget.zip
RUN mv src/* .
VOLUME /app/phpnuget/data
