brightness=$(brightnessctl | grep -oP '\d+(?=%)')
get_brightness() {
  #brightness=$(brightnessctl | grep -oP '\d+(?=%)')
  echo $brightness
}
get_icon() {
  if [ "$brightness" -le 21 ]; then
    icon="󰃞"
  elif [ "$brightness" -le 61 ]; then
    icon="󰃟"
  elif [ "$brightness" -le 100 ]; then
    icon="󰃠"
  fi
  echo $icon
}

if [[ "$1" == "--brightness" ]]; then
  get_brightness
elif [[ "$1" == "--icon" ]]; then
  get_icon
fi
