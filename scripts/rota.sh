#!/bin/bash

if [ "$(id -u)" != "0" ]
then
        echo -e "\033[44;37;1mEste programa executou uma operação ilegal e será fechado. Motivo: Precisa ser root!\033[m"
	exit
fi

	echo -n "Digite '1' para configurar rotas no notebook Sim "
	echo -n "ou '2' para configurar rotas no notebook Lenovo: "
	read operacao

case "${operacao}" in
	"1")
		route add -net 192.168.0.0/24 gw 10.0.0.1
		route add -net 192.168.3.0/24 gw 192.168.1.106
		route add -net 192.168.2.0/24 gw 10.0.0.1
		;;
	"2")
		route add -net 192.168.3.0/24 gw 10.0.0.5
		route add -net 192.168.0.0/24 gw 192.168.1.103
		route add -net 192.168.2.0/24 gw 192.168.1.103
		;;
	
	*)
		echo "Operado invalido. Tente novamente."
		;;
esac
