vzctl create 105 --ostemplate centos-7
vzctl set 105 --onboot yes --save
vzctl set 105 --hostname puppet-agent-01.devnet.int --save
vzctl set 105 --ipadd 192.168.77.55/24 --save
vzctl set 105 --nameserver 192.168.77.5 --searchdomain  devnet.int --save
vzctl set 105 --ram 512M:512M --swap 1G --save --save 
vzctl set 105 --userpasswd root:p@ssw0rd
vzctl set 105 --description "Puppet agent"
vzctl set 105 --diskspace 2G:4G
