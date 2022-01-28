FROM ubuntu:latest
MAINTAINER Fabian Clerbois <helpdesk.choc@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LETSENCRYPT_HOME /app/phpnuget/data/letsencrypt
ENV DOMAINS ""
ENV WEBMASTER_MAIL ""
ENV SSLCRT fullchain.pem
ENV SSLKEY privkey.pem


# Manually set the apache environment variables in order to get apache to work immediately.
RUN mkdir /etc/container_environment && echo /root $WEBMASTER_MAIL > /etc/container_environment/WEBMASTER_MAIL && \
    echo /root $DOMAINS > /etc/container_environment/DOMAINS && \
    echo /root $LETSENCRYPT_HOME > /etc/container_environment/LETSENCRYPT_HOME

CMD ["/sbin/my_init"]

# Base Setup
RUN apt-get update && apt-get install -y --no-install-recommends tzdata && apt-get install -y apache2 \
                       nano \
                       php \
                       software-properties-common \
                       php-cli \
                       php-mysql php-xml php-zip \
                       mariadb-server \
                       wget \
                       zip && rm -rf /var/www/html && \
                       ln -sf /app /var/www/html && \
                       apt-get -y update && \
		       apt-get install -q -y python3-certbot-apache && \
                       apt-get clean && \
                       rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && apt-get update -y
	       
# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/conf-enabled/hostname.conf && \
    a2enmod ssl headers xml2enc rewrite usertrack  && \
    mkdir -p /var/lock/apache2 && \
    mkdir -p /var/run/apache2
COPY templates/default-ssl.conf /etc/apache2/sites-enabled/

# Setting up PHPNuget
COPY templates/index.html   /app/
RUN wget https://www.kendar.org/?p=/dotnet/phpnuget/phpnuget.4.1.0.0.zip -O phpnuget.zip &&  unzip phpnuget.zip -d /app/phpnuget && chmod 755 -R /app/phpnuget/data
COPY templates/.htaccess templates/web.config templates/ManagedFusion.Rewriter.txt /app/phpnuget/


# configure runit
RUN mkdir -p /etc/service/apache
ADD config/scripts/run_apache.sh /etc/service/apache/run
ADD config/scripts/init_letsencrypt.sh /etc/my_init.d/
ADD config/scripts/run_letsencrypt.sh /run_letsencrypt.sh
RUN chmod +x /*.sh && chmod +x /etc/my_init.d/*.sh && chmod +x /etc/service/apache/*
RUN  service apache2 restart

# Finalize Docker Configurations
EXPOSE 80 443
#VOLUME [ "/app/phpnuget"]
#, "$LETSENCRYPT_HOME"
COPY run.sh /run.sh
CMD ["./run.sh"]
