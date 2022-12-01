#!/usr/bin/env bash


newport=$1
UserName=$2
Password=$3

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
        #newport=$1
        #echo "please enter ssh port number:"
        cp /etc/ssh/sshd_config /etc/ssh/sshd_config-$(date +%Y-%m-%d-%H-%M-%S).bak
        #read newport
        sed -i 's/^#Port 22/Port '$newport'/g' /etc/ssh/sshd_config
        sed -i 's/^PermitRootLogin yes$/PermitRootLogin no/g' /etc/ssh/sshd_config

        semanage port -a -t ssh_port_t -p tcp $newport
        systemctl reload-or-restart sshd
        firewall-cmd --permanent --add-port=$newport/tcp
        firewall-cmd --reload


}

sshpch_norootlog 

echo "================================================="

addgroup()
{
	echo "add Audit group"
	groupadd -g 20000 Audit
	
}

addgroup

echo "================================================="


adduser()
{
        echo "add $UserName and change password"
        #UserName=$1
	#Password=$2
        useradd -g 20000 $UserName
        echo "$Password" | passwd --stdin $UserName
	#echo "user $UserName is added and password changed"
}

adduser



echo "================================================="

creating_dated_files()
{
	echo "creating dated files"
	#UserName=$1
	if [ -e /home/$UserName/Reports ]
        then
		echo "Directory /home/$UserName/Reports already exsts"
        else
                mkdir -p /home/$UserName/Reports
        fi


        for m in {1..12}
        do
                y=$(date +%Y)
                DAYS=$(cal $m $y | awk 'NF {days = $NF}; END {print days}')
                for (( d=1; d<=$DAYS; d++ ))
                do
                        if [ -e /home/$UserName/Reports/$y-$m-$d.xls ]
                        then
                                echo "file /home/$UserName/Reports/$y-$m-$d.xls already exists "
                        else
                                touch /home/$UserName/Reports/$y-$m-$d.xls
                        fi
			chmod 660 /home/$UserName/Reports/$y-$m-$d.xls
			chown $UserName:Audit /home/$UserName/Reports/$y-$m-$d.xls
                done
        done

}

creating_dated_files



echo "================================================="

updatesys()
{
	echo "updating system"
	yum update -y
}
updatesys


echo "================================================="

epel()
{
	echo "install and enable epel"
	yum install epel-release -y
	yum-config-manager --enable epel
}
epel

echo "================================================="


fail2ban()
{
	echo "install fail2ban and enable on boot"
	yum install fail2ban -y
	systemctl start fail2ban
	systemctl enable fail2ban
	systemctl reload-or-restart fail2ban
}
fail2ban

echo "================================================="

backupreportsdir()
{
	echo "backup reports directory"
        #UserName=$1
	mkdir -p /root/backups
	echo "0 1 * * 1-5 tar -cPf /root/backups/reports-$(date +%W)-$(date +%u).tar /home/$UserName/Reports" >> "/var/spool/cron/root"
}

backupreportsdir 


echo "================================================="

manageradd()
{
	echo "add manager user"
	useradd -u 30000 manager

}
manageradd
echo "================================================="


backupreports()
{
	echo "backup reports to manager"
	#UserName=$1
        mkdir -p /home/manager/audit/reports
        echo "0 2 * * 1-5 rsync -av /home/$UserName/Reports/ /home/manager/audit/reports" >> "/var/spool/cron/root"
}

backupreports 

