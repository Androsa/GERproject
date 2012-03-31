#!/bin/bash
if [ "$(id -u)" = "0" ]
then
	echo -e "\033[44;37;1mEste programa executou uma operação ilegal e será fechado. Motivo: Você é root!\033[m"
	exit
fi
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

git pull
while true
do
	echo -e -n "Digite \033[44;37;1mcriar\033[m\c"
	echo -e -n " ou \033[41;37;1meditar\033[m\c"
	echo " para mexer em um arquivo."
	echo "Se não digitar nada vai enviar o(s) arquivo(s)"
	read opcao
	case $opcao in
		"criar")
			criar
			;;
		"editar")
			editar
			;;
		"")
			git add *
			git commit -a
			git push
			echo "comentario adicionado e enviado"
			exit
			;;
		*)
		echo "Opção inválida."
			;;
	esac
done
