wifi_icon(){
    iface=$(ip route | grep default | awk '{print $5}')

    if [[ "$iface" =~ ^wl ]]; then
        conn_type="wifi"
    else
        conn_type="eth"
    fi

    if [[ "$conn_type" == "wifi" ]]; then 
        signal_raw=$(iwconfig "$iface" 2>/dev/null | grep -i --color=never 'signal level' | awk -F '=' '{print $3}' | awk '{print $1}')
        signal_percent=$((2 * (signal_raw + 100)))
        [[ $signal_percent -gt 100 ]] && signal_percent=100
        [[ $signal_percent -lt 0 ]] && signal_percent=0
    fi

    if [[ "$signal_percent" -le 20 ]]; then
        icon="󰤯"
    elif [[ "$signal_percent" -le 40 ]]; then
        icon="󰤟"
    elif [[ "$signal_percent" -le 60 ]]; then
        icon="󰤢"
    elif [[ "$signal_percent" -le 80 ]]; then
        icon="󰤥"
    elif [[ "$signal_percent" -le 100 ]]; then
        icon="󰤨"
    fi
    echo $icon
}


if [[ "$1" == "--interface" ]]; then
  echo $iface
elif [[ "$1" == "--icon" ]]; then
  wifi_icon
fi