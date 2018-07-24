#!/bin/bash
#-------------------------------------------------------------------------
# AUTORE THIAGO MOREIRA
# FUNÇAO DO PROGRAMA BACKUP DE ARQUIVOS
#-------------------------------------------------------------------------
#OBSERVAÇÕES
#CRIAR PASTA BACKUP NO DIRETORIO /home/user/ NO SERVIDOR 1
#CRIAR PASTA BACKUP NO DIRETORIO /home/user/ NO SERVIDOR 2
#CRIAR PASTA BACKUP_PC1 NO DIRETORIO /home/user/ NO COMPUTADOR BACKUP
#CRIAR PASTA BACKUP_PC2 NO DIRETORIO /home/user/ NO COMPUTADOR BACKUP
#-------------------------------------------------------------------------
# Variáveis

# COMPUTADOR BACKUP
pcB='thiago'         #NOME DO USUARIO DE PC BACKUP
ipB='192.168.254.1'  #IP DO PC BACKUP

# COMPUTADOR SERVIDOR1
pcS1='ubuntu01'	     #NOME DO SERVIDOR 1
ip1='192.168.254.3'  #IP DO SERVIDOR 1
dirbk1='/home/ubuntu01/Documentos' #diretorio para compactar no servidor 1 e realizar backup

# COMPUTADOR SERVIDOR2
pcS2='ubuntu02'	     #NOME DO SERVIDOR 2
ip2='192.168.254.2'  #IP DO SERVIDOR 2
dirbk2='/home/ubuntu02/Documentos' #diretorio para compactar no servidor 2 e realizar backup


#-------------------------------------------------------------------------

#__BEGIN_MAIN__

#DEVE SE FAZER CONEXÃO SEM AUTENTICAÇÃO DE CHAVES ENTRE BACKUP E SERVIDOR1, SERVIDOR1 E BACKUP, BACKUP E SERVIDOR2, SERVIDOR2 E BACKUP, 
clear

#-------------------------------------------------------------------------
#IMPRIME CABEÇALHO
		echo "___________________________________________"
		echo "               Programa Backup"
		echo "		         Thiago Moreira"
		echo "___________________________________________"
#-------------------------------------------------------------------------




#________________________________________________________BACKUP DE ARQUIVOS________________________________________________________


#BACKUP SERVIDOR1__________________________________________________________________________________________________________________

#COMPACTAÇÃO________________________________________ 

#/home/"$pcS1"/BACKUP/Documentos_PC1$(diretorio onde sera salvo arquivo) /home/"$pcS1"/Documentos(Diretorio onde sera compactado)
echo 'BACKUP SERVIDOR 1'
ssh "$pcS1"@"$ip1" tar -cvzf /home/"$pcS1"/BACKUP/BACKUP_PCS1$(date +%Y_%m_%d).tar.gz "$dirbk1"
echo 'ARQUIVO COMPACTADO'


#FIM COMPACTAÇÃO____________________________________

ssh "$pcS1"@"$ip1" scp /home/"$pcS1"/BACKUP/* "$pcB"@"$ipB":/home/"$pcB"/BACKUP_PC1        #COPIA DO SERVIDOR 1 PARA COMPUTADOR BACKUP
echo 'ARQUIVO ENVIADO PARA COMPUTADOR BACKUP'
ssh "$pcS1"@"$ip1" rm /home/"$pcS1"/BACKUP/*					           #REMOVE ARQUIVO COMPACTADO DO SERVIDOR 1
echo 'ARQUIVO COMPACTADO ELIMINADO DO SERVIDOR 1'


#DEIXAR ULTIMOS 4 BACKUPS FEITOS E EXCLUIR O RESTO
ls -td1 /home/"$pcB"/BACKUP_PC1/* | sed -e '1,4d' | xargs -d '\n' rm -rif
echo 'VERIFICAÇÃO DE NUMEROS DE BACKUP NA PASTA' 
echo '!!! BACKUP DO SERVIDOR 1 CONCLUIDO !!!'
sleep 4
clear

#FIM BACKUP SERVIDOR1______________________________________________________________________________________________________________





#****************************************************************************************************************************************************


#-------------------------------------------------------------------------
#IMPRIME CABEÇALHO
		echo "___________________________________________"
		echo "               Programa Backup"
		echo "               Thiago Moreira"
		echo "___________________________________________"
#-------------------------------------------------------------------------


#BACKUP SERVIDOR2__________________________________________________________________________________________________________________
#COMPACTAÇÃO________________________________________ 
echo 'BACKUP SERVIDOR 2'
ssh "$pcS2"@"$ip2" tar -cvzf /home/"$pcS2"/BACKUP/BACKUP_PCS2$(date +%Y_%m_%d).tar.gz "$dirbk2"
echo 'ARQUIVO COMPACTADO'

#FIM COMPACTAÇÃO____________________________________

ssh "$pcS2"@"$ip2" scp /home/"$pcS2"/BACKUP/* "$pcB"@"$ipB":/home/"$pcB"/BACKUP_PC2        #COPIA DO SERVIDOR 2 PARA COMPUTADOR BACKUP
echo 'ARQUIVO ENVIADO PARA COMPUTADOR BACKUP'
ssh "$pcS2"@"$ip2" rm /home/"$pcS2"/BACKUP/*					           #REMOVE ARQUIVO COMPACTADO DO SERVIDOR 2
echo 'ARQUIVO COMPACTADO ELIMINADO DE SERVIDOR 2'


#DEIXAR ULTIMOS 4 BACKUPS FEITOS E EXCLUIR O RESTO
ls -td1 /home/"$pcB"/BACKUP_PC2/* | sed -e '1,4d' | xargs -d '\n' rm -rif
echo 'VERIFICAÇÃO DE NUMEROS DE BACKUP NA PASTA'
echo '!!! BACKUP DO SERVIDOR 2 CONCLUIDO !!!' 

#FIM BACKUP SERVIDOR2__________________________________________________________________________________________________________________





#o comando ls -td1 irá obter arquivos no formato /diretorio/arquivo, ordenandos por data e exibindo um arquivo por linha
#o comando sed -e '1,4d' selecionará os primeiros arquivos listados, omitindo os 4 últimos.

#backup realizado todos os dias as 23 horas digitar o comando abaixo que serve para editar o crontab
#sudo vim /etc/crontab
#adicionar no final do arquivo a linha abaixo 
#00 23 * * * /home/thiago/Documentos/backup.sh 
#obs: (/home/thiago/Documentos/backup.sh) diretorio onde se encontra o arquivo shell backup.sh

						    

# __END_MAIN__
