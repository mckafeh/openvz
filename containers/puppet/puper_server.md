vzctl create 104 --ostemplate centos-7
vzctl set 104 --onboot yes --save
vzctl set 104 --hostname puppet-server.devnet.int --save
vzctl set 104 --ipadd 192.168.77.54/24 --save
vzctl set 104 --nameserver 192.168.77.5 --searchdomain  devnet.int --save
vzctl set 104 --ram 512M:512M --swap 1G --save --save 
vzctl set 104 --userpasswd root:p@ssw0rd
vzctl set 104 --description "Puppet master"
vzctl set 104 --diskspace 2G:4G
