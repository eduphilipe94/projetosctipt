# #!/bin/bash

# DEFINE O ARQUIVO DO BANCO DE DADOS A SER CONSULTADO
db_file=db.txt

# CRIA O ARQUIVO SE ELE AINDA NÃO EXISTIR
if [ ! -e "$db_file" ] ; then
    touch "$db_file"
fi

# SOLICITA LOGIN E SENHA DO USUÁRIO
echo "Para continuar digite seu login:"
read USER
echo "Digite sua senha:"
read -s PASSWORD

# CALCULA A VERSÃO CRIPTOGRAFADA DO LOGIN E DA SENHA
encrypted_user=$(echo $USER -n | sha256sum | awk '{print $1}')
encrypted_password=$(echo $PASSWORD -n | sha256sum  | awk '{print $1}')

# DEFINE O CARACTER DE SEPARAÇÃO ENTRE LOGIN E SENHA NO ARQUIVO DE BD
IFS=";"

# PERCORRE O ARQUIVO PROCURANDO PELO USUÁRIO E SENHA
while read f1 f2
do
  if [ "$encrypted_user" == "$f1" ] && [ "$encrypted_password" == "$f2" ]; then

    # SE O USUÁRIO FOR ENCONTRADO COM A SENHA INFORMADA EXIBE A MENSAGEM
    echo "Usuario encontrado. Acesso autorizado."

    else

    # SE O USUÁRIO NÃO FOR ENCONTRADO EXIBE MENSAGEM DE ERRO
    echo "Usuario nao encontrado. Tente novamente."
  fi
done < $db_file