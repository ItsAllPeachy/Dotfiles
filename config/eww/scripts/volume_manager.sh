volume=$(amixer get Master | grep -oP '\[\d+%\]' | head -1 | tr -d '[]%')
get_icon() {
  if [[ "$volume" -le 1 ]]; then
    icon=" "
  elif [[ "$volume" -le 34 ]]; then
    icon=" "
  elif [[ "$volume" -le 67 ]]; then
    icon=" "
  elif [[ "$volume" -le 100 ]]; then
    icon=" "
  fi
  echo $icon
}

if [[ "$1" == "--volume" ]]; then
  echo $volume
elif [[ "$1" == "--icon" ]]; then
  get_icon
fi

