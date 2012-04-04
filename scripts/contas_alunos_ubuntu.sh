#!/bin/bash

## Nome das disciplinas
disciplinas="sst psd cod"

criarContas() {
	for disc in $disciplinas
	do
		/usr/sbin/groupadd professores 2> /dev/null
		# Cria grupo da disciplina
		/usr/sbin/groupadd $disc
		# Cria diretorio da disciplina e comum
		mkdir -p /home/$disc/comum
		# Muda permissao do diretorio para o grupo
		chown -R root.$disc /home/$disc
		chmod 770 /home/$disc/comum
		# Cria usuario para a disciplina
		for alunos in $(seq 1 20)
		do
			/usr/sbin/adduser al$alunos-$disc -p saLG2n5ESxGAo -g $disc -b /home/$disc
			chmod -R 2770 /home/$disc/al$alunos-$disc
			chown -R al$alunos-$disc.professores /home/$disc/al$alunos-$disc
			echo "al$alunos-$disc criado"
		done
	done
}

apagarContas() {
	echo "Apagando contas"
	for disc in $disciplinas
	do
		for aluno in $(seq 1 20)
		do
			echo "Apagando conta aluno: al$aluno-$disc"
			/usr/sbin/userdel -r al$aluno-$disc
		done
		/usr/sbin/groupdel $disc
	done
	echo "Apague manualmente os diretorios das disciplinas"
}


case ${1} in
	"criar")
		criarContas
		;;
	"apagar")
		apagarContas
		;;
	*)
		echo "Use ${0} (criar|apagar)"
esac		

