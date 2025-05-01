get_song_title() {
  song=$(playerctl metadata title)
  echo $song
}
get_song_artist() {
  artist=$(playerctl metadata artist)
}
get_position1() { ## Timed
  format_time() {
    mins=$(($1 / 60))
    secs=$(($1 % 60))
    printf "%d:%02d" "$mins" "$secs"
  }
  if [[ "$(playerctl status)" == "Paused" ]]; then
    icon1=
  else
    icon1=
  fi
  current=$(playerctl position | cut -d'.' -f1)
  total=$(expr $(playerctl metadata mpris:length) / 1000000)
  formatted_current=$(format_time "$current")
  formatted_total=$(format_time "$total")
  echo "$formatted_current $icon1  $formatted_total"
}
get_position2() {
  position=$(playerctl position)
  duration=$(playerctl metadata mpris:length)
  percent=$(awk -v p="$position" -v d="$duration" 'BEGIN { if (d > 0) printf "%.0f", (p * 1000000 / d) * 100; else print 0 }')
  echo $percent
}
get_cover() {
  playerctl metadata --format "{{mpris:artUrl}}" --follow | while IFS= read -r line; do
    if [[ $line == *"http"* ]]; then
      cache_dir="$XDG_RUNTIME_DIR/album_art_cache"
      mkdir -p "$cache_dir"
      file_name=$(basename "$line")
      file_path="$cache_dir/$file_name"
      if [ -e "$file_path" ]; then
        echo "$file_path"
      else
        curl --output "$file_path" "$line" >/dev/null 2>&1
        echo "$file_path"
      fi
    else
      echo "$line"
    fi
  done
}

if [[ "$1" == "--song" ]]; then
  get_song_title
elif [[ "$1" == "--artist" ]]; then
  get_song_artist
elif [[ "$1" == "--position_time" ]]; then
  get_position1
elif [[ "$1" == "--position_percent" ]]; then
  get_position2
elif [[ "$1" == "--cover" ]]; then
  get_cover
elif [[ "$1" == "--play-toggle" ]]; then
  if [[ "$(playerctl status)" == "Paused" ]]; then
    playerctl play
  elif [[ "$(playerctl status)" == "Playing" ]]; then
    playerctl pause
  fi
fi

