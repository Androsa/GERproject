#!/bin/bash

estados()
{
        case ${1} in
	"open") 
		echo "A porta ${2} está aberta."
		;;
	"closed")
		echo "A porta ${2} está fechada."
		;;
	"filtered")
		echo "O Nmap não consegue determinar se a porta ${2} está aberta, porque uma filtragem de pacotes impede que as sondagens alcancem a porta."
		;;
	"unfiltered")
		echo "A porta ${2} está acessível, mas o Nmap é incapaz de determinar se ela está aberta ou fechada."
		;;
	"open|filtered")
		echo "O Nmap é incapaz de determinar se a porta ${2} está aberta ou filtrada."
		;;
	"closed|filtered")
		echo "O Nmap é incapaz de determinar se a porta ${2} está fechada ou filtrada."
		;;
	*)
		echo ""
		;;
	esac
}

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

estados ${tcp80} "tcp 80"
estados ${tcp443} "tcp 443"
estados ${udp53} "udp 53"
estados ${udp67} "udp 67"
