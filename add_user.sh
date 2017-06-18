# #!/bin/bash

# DEFINE O ARQUIVO DO BANCO DE DADOS A SER CONSULTADO
db_file=db.txt

# CRIA O ARQUIVO SE ELE AINDA NÃO EXISTIR
if [ ! -e "$db_file" ] ; then
    touch "$db_file"
fi

# SOLICITA LOGIN E SENHA DO USUÁRIO A SER CADASTRADO
echo "Para continuar digite seu login:"
read USER
echo "Digite sua senha:"
read -s PASSWORD

# CALCULA A VERSÃO CRIPTOGRAFADA DO LOGIN E DA SENHA
encrypted_user=$(echo $USER -n | sha256sum | awk '{print $1}')
encrypted_password=$(echo $PASSWORD -n | sha256sum  | awk '{print $1}')

# PROCURA O USUÁRIO NA LISTA DE USUÁRIOS DA MÁQUINA
user_exist=$(cut -d: -f1 /etc/passwd | grep $USER)

if [ "$user_exist" == "$USER" ]; then

  # SALVA O LOGIN E A SENHA SEPARADOS POR ; NO ARQUIVO DE BANCO DE DADOS
  echo "$encrypted_user;$encrypted_password" >> $db_file

  # IMPRIME A MENSAGEM DE SUCESSO
  echo "Usuario cadastrado com sucesso"

  else
  # SE O USUÁRIO NÃO FOR ENCONTRADO EXIBE MENSAGEM DE ERRO
  echo "Usuario não existe na máquina. Portanto não pode ser adicionado."
  exit 1
fi
