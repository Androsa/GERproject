#!/bin/bash
if [ "$(id -u)" != "0" ]
then
	sudo ${0}
	exit
fi
teste=true
while $teste
do
	echo "É necessário a instalação do pacote bridge-utils."
	echo -n "Você já possui esse pacote? ([S]/n): "
	read opcao
	case $opcao in
		"S" | "s" | "")
			teste=false
			;;
		"N" | "n")
			aptitude update
			aptitude install bridge-utils -y
			teste=false
			;;
		*)
			;;
	esac
done
echo ""
echo "ATENÇÃO. Esse programa irá desconfigurar a interface eth0, sua conexão com a internet poderá ser perdida."
echo ""
echo -n "Tecle [ENTER] para avançar ou [CTRL+C] para cancelar"
	read enter
echo ""
echo "Limpando iptables."
	iptables -t nat -F POSTROUTING
echo "Ativando NAT."
	iptables -t nat -L -n -v
echo "Criando br0."
	brctl addbr br0
	ip=$(/sbin/ifconfig eth0 | grep 'inet end' | awk '{print $3}') ##Salvando ip da máquina
echo "Desconfigurando eth0."
	ifconfig eth0 0.0.0.0
echo -n "Qual a mascara do ip? /"
	read mask
echo "Configurando br0"
	ifconfig br0 $ip/$mask
echo "Ligando br0 com a eth0"
	brctl addif br0 eth0
echo -n "Adicionando rota default, Qual a rota padrão: "
	read rota
	route add default gw $rota
	user=$(/sbin/ifconfig |grep nk_tap_* |awk '{print $1}')
echo "Ligando br0 na interface virtual $user"
	brctl addif br0 $user
echo "Configure a interface da máquina virtual e adicione uma rota padrão"
echo "Ex: ifconfig eth1 172.18.200.248/16"
echo "Ex: route add default gw 172.18.0.254"
}
