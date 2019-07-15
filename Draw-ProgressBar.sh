#/bin/bash

function Get-ProgressBar {
# drawing progressbar while doing other functions
	argcnt=${#@}
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
	clear
	Draw-Bar "START" $(($max - 5)) $cols $max 0
	echo -ne '\r'
	#actual drawing
	cnt=1
	for arg in $@
	do 
		## tag
		Draw-Name $arg $(( $max - ${#arg} )) 
		## 
		cols=$(tput cols)
		pc=$[$cnt*100/($argcnt+1)]
		Draw-ProgressBar $cols $max $pc
		Draw-Percentage $pc
		echo -ne "\r"
		##do some work
		$arg
		cnt=$(($cnt+1)) 
	done
	Draw-Bar "END" $(($max - 3)) $cols $max 100
	echo ""
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
	fill=$3
	barlen=$(( $cols - $name - 10))
	barfilllen=$[$barlen*fill/100]
	barlen=$[$barlen-$barfilllen]
	for i in $(seq 1 $barfilllen)
	do
		echo -ne "#"
	done
	for i in $(seq 1 $barlen)
	do
		echo -ne "-"
	done
}

function Draw-Bar {
	name=$1
	len=$2
	cols=$3
	max=$4
	pc=$5
	Draw-Name $name $len
	Draw-ProgressBar $cols $max $pc
	Draw-Percentage $pc
}

function Draw-Percentage {
	pc=$1
	pc="$pc"
	len=${#pc}
	echo -ne "["
	if [ $len -eq 1 ]; then 
		Draw-Space 2
	fi
	if [ $len -eq 2 ]; then
		Draw-Space 1 
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

#Get-ProgressBar $@
