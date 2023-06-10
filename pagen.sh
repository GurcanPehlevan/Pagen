#! /bin/bash


function pwdgen(){
  tr -cd '[:alnum:]' < /dev/urandom | fold -w${pwd_lenght} | head -n 1
}

printf "\n"
echo "-------------------------------------"
printf "Welcome to PAssword GENarotor PAGEN\n"
echo "-------------------------------------"

i=1
while (($i>0))
do
  
  printf "What do you want to do?\n"
  printf "1) Generate Random Password\n"
  printf "2) Add Password for application\n"
  printf "3) View Password\n"
  printf "4) Exit\n\n"
  
  read -p "Enter your preference: " input
  
  if [ $input -eq 1 ]
  then
    read -p "Password length: " pwd_lenght
    printf "Password: "
    pwdgen
    printf "\n"
  elif [ $input -eq 2 ]
  then
    printf "1) Generate New Random Password\n"
    printf "2) Add existing password\n"
    
    read -p "Enter your preference: " addPwd
    printf "\n"
    if [ $addPwd -eq 1 ]
    then
      read -p "Enter the application name: " appName
      read -p "Enter URL: " url
      read -p "Enter Username: " username
      read -p "Password length: " pwd_lenght
      password=$(pwdgen)
      sqlite3 pagen.db "insert into passwords (appName,url,username,password) values (\"$appName\",\"$url\",\"$username\",\"$password\");"
      echo "Password created $password"
      printf "\n\n"
    elif [ $addPwd -eq 2 ]
    then
      read -p "Enter the application name: " appName
      read -p "Enter URL: " url
      read -p "Enter Username: " username
      read -p "Enter Password: " pwd
      sqlite3 pagen.db "insert into passwords (appName,url,username,password) values (\"$appName\",\"$url\",\"$username\",\"$pwd\");"
      echo "Password added"
      printf "\n\n"
    else
      echo "İnvalid input"
    fi
  elif [ $input -eq 3 ]
  then
    read -p "Enter the application name: " appName
    echo "-------------------------------------"
    echo "   id     |     App Name    |   URL    |     Username    |    Password   " 
    sqlite3 pagen.db "select * from passwords where appName=\"$appName\";"
    echo "-------------------------------------"
    printf "\n\n"
  elif [ $input -eq 4 ]
  echo "Exiting the application..."
  then exit 1
  else
    echo "Invalid Input."
  fi
done