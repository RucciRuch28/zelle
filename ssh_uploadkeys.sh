#!/bin/bash      
#author		     : Oruchi Opara
#CopyRights      : Dominion Systems
#Contact         : +1 781 405 5946
<<mc
This script will create an upload ssh-keys to githubAPI
It automate the ssh-keygen process for githup.
Shell scripting is goot for automation
Please make you create a token before executing this script.
https://www.youtube.com/watch?v=3YgutlExHRo&t=3632s
watch the youtube video for clarity.
mc
echo "Enter your GitHub Personal Access Token:"
read token
#echo $token >token.txt
#cat token.txt
cat ~/.ssh/id_rsa.pub
#if condition to validate weather ssh keys are already present or not
if [ $? -eq 0 ]
then
	echo "SSH Keys are already present..."
else	
echo "SSH Keys are are not present..., Create the sshkyes using ssh-keygen command"
ssh-keygen -t rsa
echo "Key successfully generated"
fi
sshkey=`cat ~/.ssh/id_rsa.pub`
if [ $? -eq 0 ]
then
echo "Copying the key to GitHub account"
curl -X POST -H "Content-type: application/json" -d "{\"title\": \"SSHKEY\",\"key\": \"$sshkey\"}" "https://api.github.com/user/keys?access_token=$token"
if [ $? -eq 0 ]
then 
echo "Successfully copied the token to GitHub"
exit 0
else
echo "Failed"
exit 1
fi
else
echo "Failure in generating the key"
exit 1
fi
