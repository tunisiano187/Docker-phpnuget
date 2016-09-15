FROM tutum/apache-php 
MAINTAINER Fabian Clerbois fabian@bowlman.org 
RUN apt-get update
RUN apt-get install -y wget \
                       zip
RUN wget http://www.kendar.org/?p=/dotnet/phpnuget/phpnuget.zip -O phpnuget.zip
RUN unzip phpnuget.zip
RUN mv src phpnuget
VOLUME /app/phpnuget/data