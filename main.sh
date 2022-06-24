#!/usr/bin/env bash

# plugins bash moderen
. lib/moduler.sh
# depencies
Bash.import: text_display/colorama text_display/IO.ECHO
Bash.import: util/io.class lambda/main
Bash.import: util/operator util/IO.SYSTEM.var

@require modules/pack.sh

def: animations(){
	global: app = "$@"
	global: frame = "/_\|"
	
	let awal=0
	let akhir=${#frame}

	asu=(
		"$me" "$ij"
		"$ku" "$cy"
		)

	for ((i = awal; i < akhir; i++)); do
		if ((i == 1)); then
			let element=0
		elif ((i == $((1 + 1)))); then
			let element=1
		elif ((i == $((1 + 2)))); then
			let element=2
		elif ((i == $((1 + 3)))); then
			let element=3
		elif ((i == $((1 + 4)))); then
			let element=4
		fi

		Tulis.str "\r$app ${asu[$element]}${frame:i:1}$st"
		sleep 01
	done
}

class da; {
	public: app = mechanize;
	public: app = ceker;
} && {
	def: da::mechanize(){
		global: url = "$@"

		var res : $(
			curl --silent \
				 --request POST \
				 --location \
				 --header "Content-Type: application/x-www-form-urlencoded" \
				 --url "https://gerfaindonesia.co.id/tools/tools/checker/cekda.php" \
				 --data-raw "url_form=$url" \
				 --insecure \
				 --compressed | grep "<tr><td>"
		)

		var regex : $(Tulis.strN "$res"|grep "<tr><td>" | sed 's;<tr>;'';g' | sed 's;<td>;'';g' | sed 's;</td>; ;g')
		var regex_array : ${regex%% <*}

		declare array=($regex_array)
		var da : ${array[2]}
		var pa : ${array[3]}
		var mr : ${array[4]}
		var el : ${array[5]}
	}

	def: da::ceker(){
		global: url = "$@"
		
		da::mechanize "$url"
		echo -e "${me}--------------------------------------------------------------------------------------------------------------"
		echo -e "${pu}URL ${me}: ${pu}${url}${ku}|${st}Da ${me}:${pu} ${da}${ku}|${pu}Pa$me :$pu $pa${ku}|${pu}Mr ${me}:${pu} $mr${ku}|${pu}EL ${me}:${pu} $el$st"
	}
}; class.new: da main

def: ct(){
	kill -9 "$sig" 1> /dev/null 2>/dev/null &> /dev/null
	echo; echo
	tput cnorm
	Tulis.strN "${ku}(${me}+${ku})${pu} Ctrl ${ij}Detected ${pu}Exit The Tools${st}"
	Tulis.strN "${ku}(${me}+${ku})${pu} Process ${ij}Finished${st}\n"
	exit
}

trap ct INT SIGINT

def: banner(){	
	Tulis.strN "\t${ku}╔═╗${pu}┬ ┬┌─┐┌─┐┬┌─┌─┐┬─┐  ${m}╔╦╗${pu}┌─┐"
	Tulis.strN "\t${ku}║  ${pu}├─┤├┤ │  ├┴┐├┤ ├┬┘  ${m} ║║${pu}├─┤"
	Tulis.strN "\t${ku}╚═╝${pu}┴ ┴└─┘└─┘┴ ┴└─┘┴└─  ${m}═╩╝${pu}┴ ┴"
}

def: run(){
	clear
	banner
	Tulis.strN "\t  \e[107m${hi}Subscribe Pejuang kentang$st\n"
	Tulis.strN "${me}========================================================$st"
	Tulis.strN "  ${ku}•${pu} Author  ${me}:${pu} Speedrun ${ku}||${pu} Polygon"
	Tulis.strN "  ${ku}•${pu} Github  ${me}:${pu} https://github.com/Speedrun-bash"
	Tulis.strN "  ${ku}•${pu} Youtube ${me}:${pu} Pejuang Kentang"
	Tulis.strN "  ${ku}•${pu} Tools   ${me}:${hi} C${pu}hecker ${ij}D${pu}a${m} v${me}.${pu}1$st"
	Tulis.strN "${me}=======================================================$st"
	Tulis.str "${me}•$pu masukan ${ku}(${hi}query${me}/${hi}list${ku})$me> $st"
	read target
	echo
	
	if (test -z "$target"); then
		Tulis.strN "${me}•${pu} Input Tidak Boleh Kosong$st\n"
		exit
	fi

	tput civis

	for x in {1..5}; do
		tput sc
		animations "${ku}•${pu} Checking Internet$st"
		tput rc
		curl -sL google.com -o /dev/null
	done

	if (($? == 0)); then
		Tulis.strN "${me}•${pu} Passed ${ij}√             $st\n\n"
	else
		Tulis.strN "${me}•${pu} Failed ${me}X             $st\n\n"
		tput cnorm
		exit
	fi
	
	if (test -f "$target"); then

		var value : $(cat $target|wc -l)
		let start=0
		let end=value
		
		while ((start < end)); do
			let start++
			var split_files : $(cat $target|tail +$start|head -1)
			tput sc
			animations "${ku}• ${pu}Checker"
			tput rc
			tput ed
			main.ceker "$split_files"
		done
		echo
		Tulis.strN "${me}•${pu} Count   ${ku}$value"
		Tulis.strN "${cy}•${pu} Process ${ij}Finished"
		Tulis.strN "$st"
		tput cnorm
		exit
	else
		var dummy : ""
	fi

	if (curl -sL google.com &> /dev/null); then
		tput sc
		animations "${me}•$pu Dorking"
		tput rc
		var::lambda dorksys = [lambda: command : python modules/dork.py "\$1"]
		var isi : $(dorksys "$target")
		tput ed
		for epep in ${isi}; do
			tput sc
			animations "${ku}•$pu Checker"
			tput rc
			if ! (test -z "$epep"); then
				tput ed
				main.ceker "$epep"
			else
				kill "$sig" &> /dev/null
				tput ed
				Tulis.strN "${me}•$pu None$st"
			fi
		done
		echo
		Tulis.strN "${me}•${pu} Process ${ku}Finished"
		Tulis.strN "${bi}•${pu} Target  ${ij}$target"
		echo
		tput cnorm
		exit
	else
		Tulis.strN "${ku}•$pu Target ${me}Not ${ij}Valid$st\n"
		tput cnorm
		exit
	fi
		
}

let start=0
let end=$(tput columns)
let start_color=0
declare block=""
. modules/pack.sh
while ((start < end)); do
	let start++
	let start_color++

	if ((start_color == 1)); then
		a="$m"
		b="$pu"
		c="$me"
		d="$pu"
	elif ((start_color == 3)); then
		a="$pu"
	elif ((start_color == 6)); then
		b="$m"
	elif ((start_color == 9)); then
		c="$pu"
	elif ((start_color == 13)); then
		d="$cy"
	elif ((start_color == 16)); then
		a="$hi"
		b="$hi"
		c="$hi"
		d="$hi"
	elif ((start_color == 22)); then
		var a : "$m"
		var b : "$pu"
		var c : "$me"
		var d : "$pu"
	elif ((start_color == 25)); then
		var a : "$me"
		var c : "$ij"
		var b : "$pu"
		var d : "$pu"
	elif ((start_color == 28)); then
		var a : "$ku"
		var c : "$bi"
		var b : "$pu"
		var d : "$pu"
	elif ((start_color == 31)); then
		var a : "$m"
		var c : "$me"
		var b : "$pu"
		var d : "$pu"
	elif ((start_color == 34)); then
		var a : "$pu"
		var b : "$pu"
		var c : "$pu"
		var d : "$pu"
	elif ((start_color == 38)); then
		let start_color=0
	fi
	
	block+=" "
	tput civis
	tput sc
	tput clear
	printf "\r${block}${ij}$ ${a}P${b}ejuang ${c}K${d}entang$st"
#	echo "$a g"
	sleep 0.1s
	tput rc
done; tput cnorm
#xdg-open ""
run
