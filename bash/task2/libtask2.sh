#!/usr/bin/env bash

echo "================================================="

checkrootprivilage()
{
	if [ $(echo $UID) -eq 0 ]
	then
		echo "User has root privilages"
		
	else
		echo "User doesn't have root privilages"
		exit
	fi

}

checkrootprivilage

echo "================================================="

sshpch_norootlog()
{
	echo "please enter ssh port number:"
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config-$(date +%Y-%m-%d-%H-%M-%S).bak
	read newport
	sed -i 's/^#Port 22/Port '$newport'/g' /etc/ssh/sshd_config
       	sed -i 's/^PermitRootLogin yes$/PermitRootLogin no/g' /etc/ssh/sshd_config

	semanage port -a -t ssh_port_t -p tcp $newport
	systemctl reload-or-restart sshd
	firewall-cmd --permanent --add-port=$newport/tcp
	firewall-cmd --reload
}

sshpch_norootlog 

echo "================================================="

adduser()
{
	echo "please enter new user name:"
	read UserName
	echo "please enter password:"
	read Password
	useradd -m -p $Password $UserName
	echo "Do you want to add user to the sudoers?(y/n):"
	read answer
	if [ "$answer" == "y" ]
	then
		usermod -aG wheel $UserName
		echo "sudoer user"
	else
		echo "not sudoer user"
	fi
}

adduser 

echo "================================================="

backuphomedir()
{
	echo "Please enter user you want to backup his/her homedir:"
	read user
	echo "@weekly rsync -av /home/$user /home/Backupshomedir/" >> "/var/spool/cron/root"
}

backuphomedir
