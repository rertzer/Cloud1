FROM debian:trixie

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        wget \
        curl \
        php8.4 \
        php8.4-fpm \
        php8.4-mysql \
        php8.4-curl \
        php8.4-gd \
        php8.4-mbstring \
        php8.4-xml \
        php8.4-zip \
        mariadb-client \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
 RUN chown -R root:root /var/www/html

COPY conf/www.conf /etc/php/8.4/fpm/pool.d/www.conf
 RUN chmod 755 /etc/php/8.4/fpm/pool.d/www.conf

COPY ./tools/wp_conf.sh /usr/local/bin/wp_conf.sh
RUN chmod 755 /usr/local/bin/wp_conf.sh


RUN mkdir -p /run/php 

RUN wget https://wordpress.org/wordpress-7.0.3.tar.gz -P /var/www/html
RUN cd /var/www/html && tar -xzf wordpress-7.0.3.tar.gz && rm wordpress-7.0.3.tar.gz


RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html/wordpress

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp_conf.sh"]
