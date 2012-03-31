#!/bin/bash

#Função enter: para deixar a execução do programa mais amigável
enter(){
	echo ""
	echo "Tecle [Enter] para avançar..."
	echo ""
	read enter
}

#Função auxiliar: listar os arquivos especiais (named pipes e unix sockets)
arquivosEspeciais()
{
	echo "Arquivos do tipo 'namedpipe'. Por favor, aguarde..."
	find / -type p -ls 2> /dev/null | more
	echo ""
	echo "Agora, os arquivos do tipo 'unix socket'. Mais uma vez, aguarde..."
	enter
	find / -type s -ls 2> /dev/null | more
}

#Função serviço: lista os serviços conforme seu nome, dono, protocolo ou porta
servico(){
	lsof -n -P | grep TCP | grep ${1}
	lsof -n -P | grep UDP | grep ${1}
}

#Função principal: menu interativo
while true
do
	clear
	echo "Opções:"
	echo "1) listar arquivos especiais: 'named pipes' e 'unix sockets'."
	echo "2) listar serviços (Sockets)."
	echo "3) sair do programa."
	echo ""
	echo -n "Escolha uma opção pelo seu número: "
	read opcao1
	case ${opcao1} in
		"1")	
			arquivosEspeciais
			;;
		"2")
			echo "Lista serviços por nome de processo, dono ou porta?"
			echo "1) Listar serviços por nome de processo."
			echo "2) Listar serviços por dono."
			echo "3) Listar serviços por protocolo."
			echo "4) Listar serviço por porta."
			echo "5) Encerrar um processo pelo seu numero."			
			echo -n "Número: "
			read opcao2
			case ${opcao2} in
				"1")
					echo -n "Digite o nome do serviço que deseja listar: "
					read nome
					#grep (filtra linhas) e o (cut filtra coluna)
					servico ${nome}
					enter
					;;
				"2")
					echo -n "Digite o nome do usuário: "
					read usuario
					servico ${usuario}
					enter
					;;
				"3")
					echo -n "Digite o nome do protocolo que deseja listar: "
					read proto
					if [ ${proto} = "tcp" ]
					then
						lsof -n | grep TCP | cut -d \  -f 1
					fi
					if [ ${proto} = "udp" ]
					then
						lsof -n | grep UDP | cut -d \  -f 1
					fi
					enter
					;;
				"4")
					echo -n "Digite o número da porta: "
					read porta
					servico ${porta}
					enter
					;;
				"5")	
					ps -aux | more
					echo -n "Digite o número do PID do processo: "
					read numprocesso
					killall -9 ${numprocesso}
					enter
					;;
				*)
					echo "Por favos, leia com atenção, digite um numero válido!"
			esac
			;;
		"3")
			exit
			;;
		*)
			echo "Por favos, leia com atenção, digite um numero válido!"
	esac
done
