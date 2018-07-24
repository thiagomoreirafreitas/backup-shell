# Backup Shell
Código Shell Script para backup e agendamento de backup. O script tem as seguintes funções:
- Compactar diretório ou arquivo que se deseja realizar o backup de Servidores em determinado diretório;
- Enviar arquivo compactado remotamente para o computador Backup em um diretório destinado para armazenar dados dos Servidores;
- Excluir o arquivo compactado presente nos Servidores;
- Se tiver mais de 4 backups serão selecionados os 4 mais atuais e excluirá os arquivos restantes;
- No final do arquivo é exemplificado como editar o Crontab para executar a rotina todos os dias as 23 horas.
