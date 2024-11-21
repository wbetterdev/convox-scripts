#!/bin/bash

DNS_NAME=waybetter.com
CERT_NAME=dietbet-selfsigned

cd "/home/mihai/Work/docs/certs/apache/"
mv "$CERT_NAME" "$CERT_NAME-old"
mkdir "$CERT_NAME"

cd "$CERT_NAME"

openssl genrsa -des3 -out "$CERT_NAME-rootCA.key" 4096

openssl req -x509 -new -nodes \
    -subj "/C=US/ST=NY/O=Waybetter/OU=IT/CN=$DNS_NAME/emailAddress=mihai@waybetter.com" \
    -addext "subjectAltName=DNS:$DNS_NAME" \
    -key "$CERT_NAME-rootCA.key" -sha256 -days 3650 \
    -out "$CERT_NAME-rootCA.crt"

openssl x509 -text -noout -in "$CERT_NAME-rootCA.crt"
read

openssl genrsa -out "$CERT_NAME.key" 2048

openssl req -new -sha256 \
    -subj "/C=US/ST=NY/O=Waybetter/OU=IT/CN=*.$DNS_NAME/emailAddress=mihai@waybetter.com" \
    -addext "subjectAltName = DNS:*.$DNS_NAME" \
    -key "$CERT_NAME.key" -out "$CERT_NAME.csr"

openssl req -in "$CERT_NAME.csr" -noout -text
read

openssl x509 -req -in "$CERT_NAME.csr" -CAcreateserial \
    -CA "$CERT_NAME-rootCA.crt" \
    -CAkey "$CERT_NAME-rootCA.key" \
    -out "$CERT_NAME.crt" -days 3650 -sha256

openssl verify -CAfile "$CERT_NAME-rootCA.crt" "$CERT_NAME.crt"
