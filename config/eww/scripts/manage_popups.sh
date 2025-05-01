if [[ "$1" == "--musicwindow" ]]; then
    if eww active-windows | grep -q 'musicwindow'; then
        eww close musicwindow
    else
        eww open musicwindow
    fi
fi
    
    
