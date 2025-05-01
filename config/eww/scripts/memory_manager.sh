free_as_percent(){
    percent=$(free | awk '/Mem:/ {printf("%d\n", $3/$2 * 100)}')
    echo $percent
}

if [[ "$1" == "--used" ]]; then
    free_as_percent
elif [[ "$1" == "--poes" ]]; then 
    echo "123"
fi
