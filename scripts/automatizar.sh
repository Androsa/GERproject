#!/bin/bash

#Função auxiliar: listar os arquivos especiais (named pipes e unix sockets)
arquivosEspeciais()
{
	echo "Arquivos do tipo 'namedpipe'. Por favor, aguarde..."
	find / -type p -ls 2> /dev/null | more
	echo ""
	echo "Agora, os arquivos do tipo 'unix socket'. Mais uma vez, aguarde..."
	echo "Tecle [Enter] para avançar..."
	read enter
	find / -type s -ls 2> /dev/null | more
}

#Função principal: menu interativo
while true
do
	clear
	echo "Opção1:"
	echo "1) listar arquivos especiais: 'named pipes' e 'unix sockets'."
	echo "2) listar serviços."
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
			echo "2) listar serviços por dono."
			echo "3) listar serviços por protocolo."
			echo "4) Encerrar um processo."
			echo "5) listar serviço por porta."
			echo -n "Número: "
			read opcao2
			case ${opcao2} in
				"1")
					echo -n "Digite o nome do serviço que deseja listar: "
					read nome
					#grep (filtra linhas) e o (cut filtra coluna)
					lsof -n -P | grep TCP | grep LISTEN | grep ${nome}
					lsof -n -P | grep UDP | grep LISTEN | grep ${nome}
					echo "Tecle [Enter] para avançar..."
					read enter
					;;
				"2")
					echo -n "Digite o nome do usuário: "
					read usuario
					lsof -n -P | grep TCP | grep LISTEN | grep ${usuario}
					lsof -n -P | grep UDP | grep LISTEN | grep ${usuario}
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
					;;
				"4")
					echo -n "Digite o nome do processo que você deseja encerrar: "
					read nomeprocesso
					killall -u ${nomeprocesso}
					;;
				"5")
					echo -n "Digite o número da porta: "
					read porta
					lsof -n -P | grep TCP | grep LISTEN | grep ${porta}
					lsof -n -P | grep UDP | grep LISTEN | grep ${porta}
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
