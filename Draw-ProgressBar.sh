#/bin/bash

# $(()) - inside mathematical operation


function Draw-ProgressBar {
# drawing progressbar while doing other functions
	argcnt=${#@}
	
	#finding max length of parameter
	max=0
	for arg in $@
	do
		arglen=${#arg}
		if [ arglen > max ] 
		then
			$max=$arglen
		fi
	done

	#actual drawing
	for i in $@
	do
		cols=$(tput cols)
		echo -ne "[$argcnt]"
		$i
	done
}
Draw-ProgressBar 1 2 3
