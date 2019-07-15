#/bin/bash

function Get-ProgressBar {
# drawing progressbar while doing other functions
	argcnt=${#@}
	echo "$argcnt"
	#finding max length of parameter
	max=0
	for arg in $@
	do
		arglen=${#arg}
		if [ $arglen -gt $max ] 
		then
			max=$arglen
		fi
	done

	cols=$(tput cols)
	Draw-Bar "START" $(($max - 5)) $cols $max 0
	#actual drawing
	cnt=1
	for arg in $@
	do 
		## tag
		Draw-Name $arg $(( $max - ${#arg} )) 
		## 
		cols=$(tput cols)
		


		Draw-ProgressBar $cols $max 

		Draw-Percentage $cnt $argcnt

		##do some work
		#$arg
		cnt=$(($cnt+1)) 
		#echo -ne "\r"
		echo -ne ""
	done
	Draw-Bar "END" $(($max - 3)) $cols $max 100
} 

function Draw-Name {
	name=$1
	len=$2
	before=$(( $len / 2 ))
	after=$(( $len - $before ))
	echo -ne "["
	Draw-Space $before
	echo -ne "$name"
	Draw-Space $after
	echo -ne "]"
}

function Draw-ProgressBar {
	cols=$1
	name=$2+2
	
	barlen=$(( $cols - $name - 6 - 4))
	for i in $(seq 1 $barlen)
	do
		i=$(( $i % 10))
		echo -ne "$i"
	done
}

function Draw-Bar {
	name=$1
	len=$2
	cols=$3
	max=$4
	pc=$5
	Draw-Name $name $len
	Draw-ProgressBar $cols $max
	Draw-Percentage $pc
	echo ""
}

function Draw-Percentage {
	pc=$1
	pc="$pc"
	len=${#pc}
	echo -ne "["
	if [ $len -eq 1 ]; then 
		echo -ne "--" 
	fi
	if [ $len -eq 2 ]; then
		echo -ne "-" 
	fi
	echo -ne "$pc"
	echo -ne "%"
	echo -ne "]"
}

function Draw-Space {
	for i in $(seq 1 $1)
		do
			echo -ne " "
		done
}

Get-ProgressBar $@
