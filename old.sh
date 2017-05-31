# #!/bin/bash
echo "Para acessar o arquivo do Banco de Dados digite seu usúario:"
read USER
if [ $USER = "Eduardo"]
then
echo " $USER, Usuário Autorizado"
cat /var/lib/mysql/redesnassau.frm
else
echo "Você não tem permissão para acessar este arquivo"
exit 127
fi

exit 1
