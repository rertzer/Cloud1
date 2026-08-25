#!/bin/bash

set -a
source srcs/.env
set +a

cd srcs/certificate

if [ -e ./maria_ssl/cloud-ca.pem ]; then
	echo "Nothing to be done"
	exit 0
fi

mkdir ./maria_ssl

# CA private key
openssl genrsa -out cloud-ca-key.pem 4096

# Create CA
openssl req -x509 -new -nodes \
	-key cloud-ca-key.pem \
	-sha256 \
	-days 365 \
	-out maria_ssl/cloud-ca.pem \
	-subj "/C=${COUNTRY}/ST=${STATE}/L=${CITY}/O=${ORG}/OU=${ORG_UNIT}/CN=${COMMON_NAME}"

# MariaDB private key
openssl genrsa -out maria_ssl/maria-key.pem 4096

# MariaDB Certificate Signing Request
openssl req -new -key maria_ssl/maria-key.pem -out maria.csr -subj "/C=${COUNTRY}/ST=${STATE}/L=${CITY}/O=${ORG}/OU=${ORG_UNIT}/CN=${MARIA_DNS}" 

# MariaDB certificate
openssl x509 -req -in maria.csr -CA maria_ssl/cloud-ca.pem -CAkey cloud-ca-key.pem -CAcreateserial -out maria_ssl/maria-cert.pem -days 365 -sha256 -extfile server-ext.cnf  


# Check everything OK
openssl x509 -in maria_ssl/maria-cert.pem -noout -subject -issuer -ext subjectAltName
openssl verify -CAfile maria_ssl/cloud-ca.pem maria_ssl/maria-cert.pem
