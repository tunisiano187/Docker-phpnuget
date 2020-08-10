FROM ubuntu:latest
MAINTAINER Fabian Clerbois fabian@bowlman.org 
RUN apt-get update
RUN apt-get install -y apache2 \
                       php \
                       php-cli \
                       php-mysql \
                       mariadb-server \
                       wget \
                       zip
RUN wget https://www.kendar.org/?p=/dotnet/phpnuget/phpnuget.zip -O phpnuget.zip
RUN unzip phpnuget.zip
RUN mv src phpnuget
VOLUME /app/phpnuget/data
