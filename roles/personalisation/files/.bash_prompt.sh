function prompt_command {

TERMWIDTH=${COLUMNS}

#   Calculate the width of the prompt:

hostnam=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
#   "whoami" and "pwd" include a trailing newline
usernam=$(whoami)
cur_tty=$(tty | sed -e "s/.*tty\(.*\)/\1/")
newPWD="${PWD}"
#   Add all the accessories below ...
let promptsize=$(echo -n "--(${usernam}@${hostnam}:${cur_tty})---(${PWD})--" \
                 | wc -c | tr -d " ")
let fillsize=${TERMWIDTH}-${promptsize}
fill=""
while [ "$fillsize" -gt "0" ] 
do 
    fill="${fill}-"
	let fillsize=${fillsize}-1
done

if [ "$fillsize" -lt "0" ]
then
   let cut=3-${fillsize}
	newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cut\}\)\(.*\)/\2/")"
fi
}

PROMPT_COMMAND=prompt_command

function twtty {

local GRAY="\[\033[1;30m\]"
local LIGHT_GRAY="\[\033[0;37m\]"
local WHITE="\[\033[1;37m\]"
local NO_COLOUR="\[\033[0m\]"

local GREEN='\[\033[0;32m\]'
local LIGHTGREEN='\[\033[1;32m\]'
local LIGHT_BLUE="\[\033[1;34m\]"

local MAIN_COLOUR=$GREEN

case $TERM in
    xterm*)
        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac

PS1="$TITLEBAR\
$MAIN_COLOUR-$LIGHT_BLUE-(\
$MAIN_COLOUR\$usernam$LIGHT_BLUE@$MAIN_COLOUR\$hostnam$LIGHT_BLUE:$WHITE\$cur_tty\
${LIGHT_BLUE})-${MAIN_COLOUR}-\${fill}${LIGHT_BLUE}-(\
$MAIN_COLOUR\${newPWD}\
$LIGHT_BLUE)-$MAIN_COLOUR-\
\n\
$MAIN_COLOUR-$LIGHT_BLUE-(\
$MAIN_COLOUR\$(date +%H:%M)$LIGHT_BLUE:$MAIN_COLOUR\$(date \"+%a,%d %b %y\")\
$LIGHT_BLUE:$WHITE\$$LIGHT_BLUE)-\
$MAIN_COLOUR-\
$NO_COLOUR " 

PS2="$LIGHT_BLUE-$MAIN_COLOUR-$MAIN_COLOUR-$NO_COLOUR "

}

twtty
