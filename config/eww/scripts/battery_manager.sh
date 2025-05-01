get_percent() {
  BAT=`ls /sys/class/power_supply | grep BAT | head -n 1`
  percent=$(cat /sys/class/power_supply/${BAT}/capacity)
  echo "$percent"
}
bat_percent=$(get_percent)
get_icon(){
  charging=false
  if [[ "$(cat /sys/class/power_supply/BAT0/status)" == "Charging" ]]; then
    icon=""
  else
    if [ "$bat_percent" -le 6 ]; then
      icon="󰂃"
    elif [ "$bat_percent" -le 16 ]; then
      icon="󰁻"
    elif [ "$bat_percent" -le 26 ]; then
      icon="󰁼"
    elif [ "$bat_percent" -le 41 ]; then
      icon="󰁽"
    elif [ "$bat_percent" -le 56 ]; then
      icon="󰁾"
    elif [ "$bat_percent" -le 61 ]; then
      icon="󰁿"
    elif [ "$bat_percent" -le 76 ]; then
      icon="󰂂"
    elif [ "$bat_percent" -le 95 ]; then
      icon="󰂂"
    else
      icon="󰁹"
    fi
  fi
  echo "$icon"
}

if [[ "$1" == "--percent" ]]; then
  echo "$bat_percent"
elif [[ "$1" == "--icon" ]]; then
  get_icon
fi
