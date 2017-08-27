#!/bin/bash
#!file_name scan_port_cpu.sh
ScriptPID=$$
ScriptName=$0
today=$(date +%F-%H%M%S)
Now=$(date)
Nmaplogfile=/opt/diamond/nmap_logfile
Cpulogfile=/opt/diamond/cpu_log
[ ! -d $Nmaplogfile ] && mkdir -p nmap_logfile
[ ! -d $Cpulogfile  ] && mkdir -p cpu_log
if [ -f "${Nmaplogfile}/nmap_normal_${today}" ] ;then
     echo "file exist"
     break
else
    touch /opt/diamond/nmap_logfile/nmap_normal_${today} && chmod 777 *
fi

if [ -f "${Nmaplogfile}/nmap_quick_${today}" ] ;then
     echo "file exist"
     break
else
    touch /opt/diamond/nmap_logfile/nmap_quick_${today} && chmod 777 *
fi
if [ -f "${Nmaplogfile}/nmap_full_${today}" ] ;then
     echo "file exist"
     break
else
    touch /opt/diamond/nmap_logfile/nmap_full_${today} && chmod 777 *
fi

STARTTIME="==============================================================================start=============================================================================="
ENDTIME="==============================================================================ending=============================================================================="
while :
do
   read -p "please type the tcp/ip version type "4" is ipv4 ;type "6" is ipv6=> :"  ver
    case $ver in
        4 ) ver=4 && break;;
        6 ) ver=6 && break;;
        * ) echo "invaild option!!" ;;
   esac
done
[ `echo $ver | egrep -c "^[46]$"` -eq 0 ] && echo "Version ERROR" && exit
cpu_box(){
	val1=$1
	while :
	do
		M=$(cat /proc/meminfo | grep MemFree)
		echo " $(date "+%FT%T"), $M"   >>"${Cpulogfile}/${val1}_Total"
		top_op=$(top -b -n1 | grep 'nmap' | grep 'script-args')
		echo " $(date "+%FT%T"),  $top_op"  >>"${Cpulogfile}/${val1}_nmap_usage"
		./cpu_sample >>"${Cpulogfile}/${val1}_cpu_usage" 
		sleep 1
	done
}
CleanReservedPID()
{
	# This will kill the background process, and it also kill subprocess
	# pid from the script to avoid currently script pid. 
	[ ! -z $1 ] && kill $1
	for each_process in `ps -ef | grep "$ScriptName" | awk '{print $2}'`
	do
		if [ "$each_process" != "$ScriptPID" -a ! -z $each_process ]; then
			kill -9 $each_process
		fi
	done
}
while :
do  # Set default trap
	trap 2
more << EOF
# Please type numer #
 [1] is Full_scan
 [2] is Normal_scan
 [3] Quick_scan
 [4] Exit
EOF
    read -p "=>:" REPLY
    case $REPLY in
  1) 
     # Because of function cpu_box executed in background, it can not be intterupted,
     # or it will be unstoppable. So we have to set trap to disable ctrl + C
     trap '' 2
     cpu_box $today &
	 echo $STARTTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_full_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126 --server alpha --Full 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_full_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_full_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_full_${today}"
     echo $Now >> "${Nmaplogfile}/nmap_full_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126 --server alpha --Full 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_full_${today}"
     echo $Now >> "${Nmaplogfile}/nmap_full_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 sleep 2 
	 echo $STARTTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_full_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Full 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_full_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_full_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 echo $Now  >> "${Nmaplogfile}/nmap_full_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Full 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_full_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_full_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_full_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Full 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_full_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_full_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_full_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Full 10 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_full_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_full_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_full_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Full 20 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_full_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_full_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_full_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Full 30 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_full_${today}"
     echo $Now >> "${Nmaplogfile}/nmap_full_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_full_${today}"
	 sleep 2
	 CleanReservedPID $!
    ;;

  2)
     trap '' 2
     cpu_box $today &
     echo $STARTTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_normal_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126 --server alpha --Normal 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $Now >> "${Nmaplogfile}/nmap_normal_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126 --server alpha --Normal 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_normal_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Normal 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_normal_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Normal 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_normal_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Normal 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_normal_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Normal 10 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 sleep 2 
     echo $STARTTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_normal_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Normal 20 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_normal_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Normal 30 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_normal_${today}"
     echo $Now >> "${Nmaplogfile}/nmap_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_normal_${today}"
	 sleep 2
	 CleanReservedPID $!
    ;;
 
   3)
     trap '' 2
     cpu_box $today &
     echo $STARTTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_quick_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126 --server alpha --Quick 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $Now >> "${Nmaplogfile}/nmap_quick_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126 --server alpha --Quick 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_quick_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Quick 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_quick_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Quick 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_quick_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Quick 5 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_quick_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Quick 10 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_quick_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Quick 20 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $Now  >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $ENDTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 sleep 2
     echo $STARTTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 echo $Now >> "${Nmaplogfile}/nmap_quick_${today}"
    ./isc_sample_1046 -$ver 192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126,192.168.2.126 --server alpha --Quick 30 --nmapPath /opt/diamond/nmap/bin/nmap --workPath /opt/diamond/tempI/ --cltCertPath /opt/diamond/certs/enc_stg_cert.pem --cltKeyPath /opt/diamond/certs/enc_stg_key.pem --srvCertPath /opt/diamond/certs/enc_stg_srv_cert.pem --keypass SqIO2FYpqrwIhT7k --quality A >> "${Nmaplogfile}/nmap_quick_${today}"
     echo $Now >> "${Nmaplogfile}/nmap_quick_${today}"
	 echo $ENDTIME >> "${Nmaplogfile}/nmap_quick_${today}"
	 sleep 2
	 CleanReservedPID $!
	 ;;
	 4 ) exit;;
	 * ) echo "Invalid option.";;
     
    esac
done
  
