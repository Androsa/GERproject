#!/bin/bash

# Tem um endereço para testar?
if [ "${1}" = "" ]
then
	echo "Use: ${0} <IP>"
exit
fi

# Alerta
echo "Isso pode demorar alguns segundos."

# Coleta de dados: quantidade de ping respondidos
RESPOSTA=$(ping -c 3 ${1} | grep received | cut -d, -f 2 | cut -d r -f 1)
#echo ${RESPOSTA}


# Teste das portas TCP 80 e 443 e portas UDP 53 e 67
tcp80=$(nmap ${1} -p 80 |grep '80/tcp' |awk '{print $2}')
tcp443=$(nmap ${1} -p 443 |grep '443/tcp' |awk '{print $2}')
udp53=$(nmap ${1} -p 53 -sU |grep '53/udp' |awk '{print $2}')
udp67=$(nmap ${1} -p 67 -sU |grep '67/udp' |awk '{print $2}')

# teste: pelo menos um ping retornou?
if [ "${RESPOSTA}" -gt "0" ]
then
	echo "No ar."
else
	echo "Fora do ar"
fi

if [ "${tcp80}" = "open" ]
then
	echo "A porta TCP 80 está aberta."
else
	echo "A porta TCP 80 está fechada."
fi

if [ "${tcp443}" = "open" ]
then
	echo "A porta TCP 443 está aberta."
else
	echo "A porta TCP 443 está fechada."
fi

if [ "${udp53}" = "open" ]
then
	echo "A porta UDP 53 está aberta."
else
	echo "A porta UDP 53 está fechada."
fi

if [ "${udp67}" = "open" ]
then
	echo "A porta UDP 67 está aberta."
else
	echo "A porta UDP 67 está fechada."
fi
