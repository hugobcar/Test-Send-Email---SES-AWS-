#!/bin/sh

################################################################
#         TESTE DE ENVIO DE EMAIL PELO SES - AWS
#
#                       Hugo Branquinho de Carvalho - 22/09/2016
################################################################

# Binarios
OPENSSL=`which openssl`
BASE64=`which base64`

# Verifica se binarios estao instalados
if [ "${OPENSSL}" = '' ]; then
	echo "Openssl não instalado, favor instala-lo!"
	echo "     apt-get install openssl"
	echo "     yum install openssl"

	exit 1
fi


echo -n "SMTP Username: "
read smtpuser

echo -n "SMTP Password: "
read smtppassword

echo -n "FROM: "
read smtpfrom

echo -n "TO: "
read smtpto

# Converte Username and Password para base64
b64_username=`echo -n ${smtpuser} | ${BASE64}`
b64_password=`echo -n ${smtppassword} | ${BASE64}`


${OPENSSL} s_client -crlf -quiet -connect email-smtp.us-east-1.amazonaws.com:465 <<EOF
AUTH LOGIN
${b64_username}
${b64_password}
MAIL FROM:${smtpfrom}
RCPT TO:${smtpto}
DATA
Subject:Testando envio SES - Shell script
teste 123
teste 123
.
bye
EOF


