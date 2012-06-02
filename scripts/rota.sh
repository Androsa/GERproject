#!/bin/bash

if [ "$(id -u)" != "0" ]
then
        echo -e "\033[44;37;1mEste programa executou uma operação ilegal e será fechado. Motivo: Precisa ser root!\033[m"
	exit
fi

dns () {
	mv /etc/resolv.conf /etc/resolv.conf.original
	echo domain rtfm.com.br > /etc/resolv.conf
	echo search rtfm.com.br >> /etc/resolv.conf
	echo nameserver 192.168.2.7 >> /etc/resolv.conf
	echo nameserver 192.168.2.8 >> /etc/resolv.conf
	}

	echo -n "Digite '1' para configurar rotas no notebook Sim,"
	echo -n " '2' para configurar rotas no notebook Lenovo "
	echo -n "ou '3' para desfazer a configuração do dns: "
	read operacao

case $operacao in
	"1")
		#ip1=$(/sbin/ifconfig eth0 | grep 'inet end' | awk '{print $3}')
		route add -net 192.168.0.0/24 gw 10.0.0.1
		route add -net 192.168.3.0/24 gw 192.168.0.108
		route add -net 192.168.2.0/24 gw 10.0.0.1
		dns
		echo "Pronto....!"
		;;
	"2")
		#ip2=$(/sbin/ifconfig wlan0 | grep 'inet end' | awk '{print $3}')
		route add -net 192.168.3.0/24 gw 10.0.0.5
		route add -net 192.168.0.0/24 gw 192.168.0.116
		route add -net 192.168.2.0/24 gw 192.168.0.116
		dns
		echo "Pronto....!"
		;;
	"3")
		mv /etc/resolv.conf.original /etc/resolv.conf
		echo "Pronto....!"
		;;
	
	*)
		echo "Opção invalida. Tente novamente."
		;;
esac
