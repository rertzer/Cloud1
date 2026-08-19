FROM	debian:trixie

ARG DOMAIN_NAME
ARG CERT_UID
ARG COUNTRY
ARG STATE
ARG CITY
ARG ORG
ARG ORG_UNIT
ARG MARIA_DNS

RUN	apt-get update && apt-get upgrade -y && apt-get install mariadb-server openssl -y


RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 755 /var/run/mysqld
COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	./tools/init_mariadb.sh /usr/local/bin/init_mariadb.sh
RUN	chmod 755 /usr/local/bin/init_mariadb.sh


RUN mkdir /etc/mysql/ssl


EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init_mariadb.sh"]
