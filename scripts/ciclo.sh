#!/bin/bash
if [ "$(id -u)" = "0" ]
then
	echo -e "\033[44;37;1mEste programa executou uma operação ilegal e será fechado. Motivo: Você é root!\033[m"
	exit
fi

help ()	 {
	echo ""
	echo "[c] - Cria um arquivo."
	echo "[e] - Editar um arquivo."
	echo "[:] - Abre linha de comando."
	echo "[send] - Envia as alterações."
	echo "[exit] - Sair do programa sem salvar."
	echo "[help] - Lista os comandos válidos."
	echo ""
	}
criar () {
	echo -n "Nome do arquivo: "
	read nome
	gedit $nome
	}
editar () {
	ls -lR |more
	echo -n "Escolha o arquivo: "
	read arquivo
	gedit $arquivo
	}

clear
echo "Baixando arquivos do github"
git pull
while true
do
	echo -e -n "Digite \033[44;37;1m[c]\033[m\c"
	echo -e -n " para criar ou \033[41;37;1m[e]\033[m\c"
	echo " para editar um arquivo."
	echo "Digite help para ajuda."
	echo ""
	read opcao
	case $opcao in
		"c")
			criar
			;;
		"e")
			editar
			;;
		"send")
			git add *
			git commit -a
			git push
			echo "Comentario adicionado e enviado."
			echo ""
			exit
			;;
		":")
			while true
			do
			bash=$(pwd)
			echo -n "$bash/ "
			read comando
			$comando
			done
			;;
		"help")
			help
			;;
		"exit")
			exit
			;;
		*)
		echo "Opção inválida."
		echo ""
			;;
	esac
done
