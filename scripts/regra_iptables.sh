#!/bin/bash

#Política padrão: bloqueio na entrada
iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

#Limpeza das regras antigas
iptables -F

#Exceções: regras mínimas
iptables -i lo -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT

#Exceções: serviços (SSH para máquina local)
iptables -A INPUT -i eth0 -s 192.168.10.0/24 -p tcp --dport 22 \ --syn -j ACCEPT

#Exceções: serviços (SSH para servidor interno)
iptables -A INPUT -i eth0 -d 172.18.66.6 -p -tcp --dport 22 \ --syn -j ACCEPT
iptables -A FORWARD -i eth0 -d 172.18.66.6 -p -tcp --dport 22 \ --syn -j ACCEPT
