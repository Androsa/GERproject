#!/bin/bash
if [ "$(id -u)" = "0" ]
then
	echo -e "\033[44;37;1mEste programa executou uma operação ilegal e será fechado. Motivo: Você é root!\033[m"
	exit
fi

help ()	 {
	echo "[c] - Cria um arquivo."
	echo "[e] - Editar um arquivo."
	echo "[:] - Abre linha de comando."
	echo "[exit] - Sair do programa sem salvar"
	echo "[help] - Lista os comandos válidos"
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
	echo "Se não digitar nada vai enviar o(s) arquivo(s)"
	echo "Digite help para ajuda."
	read opcao
	case $opcao in
		"c")
			criar
			;;
		"e")
			editar
			;;
		"")
			git add *
			git commit -a
			git push
			echo "comentario adicionado e enviado"
			exit
			;;
		":")
			while true
			do
			echo -n "> "
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
			;;
	esac
done
