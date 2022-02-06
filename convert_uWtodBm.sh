#!/bin/bash
function Convert_uWtodBm {

########### FORMULA ##########
#### mW = [10^(dBm/10)]*1000 #
##############################

power=$1;
power=`echo "scale = 10; $power/1000"|bc`;
numerator=$(echo "scale = 10; l($power)" | bc -l);
denominator=2.3026; # Log_base10 value

#### final answer
f_decible=$(echo "scale = 10; 10*($numerator/$denominator)" | bc -l);
echo $f_decible;

}
function Convert_negativeuWtodBm {

power=$1

power=`echo "scale = 10; $power/1000" | bc`

#### final answer
f_decible=$(echo "scale = 10; 10*$power" | bc -l)
echo $f_decible

}
OID=$3;
ip=$2;
SNMP_COM=$1;
SNMP_INDEX=$4;

if [[ ! $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
	echo "Not valid ip $ip";
	exit;
fi

VL=$(snmpwalk -v 2c -Oqv -c ${SNMP_COM} ${ip} ${OID}.${SNMP_INDEX}|sed  's/\ /-1/g' 2>/dev/null);
if [ "$VL" -gt "0" ]; then
	VL_dBm=$(Convert_uWtodBm $VL);
else 
	VL_dBm=$(Convert_negativeuWtodBm $VL);
fi

echo "$# :: $1 : $2 : $3 : $4 : $5 => $VL : $VL_dBm" >> /tmp/Convert_uWtodBm.log
echo "$VL_dBm";
