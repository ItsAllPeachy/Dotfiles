#poes
## Credit:
## https://codeberg.org/JustineSmithies/hyprland-dotfiles
## Stole: Socat command(changed location), button echo formation

workspaces() {
  pullactive=$(hyprctl monitors -j | jq '.[0].activeWorkspace.id')
  workspaces=(null 1 2 3 4 5 6)
  for space in "${workspaces[@]}"; do
    if [[ "$space" -eq "$pullactive" ]]; then
      declare "ws$space=active"
      declare "icon_ws$space="
    else
      declare "ws$space=inactive"
      declare "icon_ws$space="
    fi
  done

  echo "(eventbox :class \"eventbox1\" \
          (box :class \"workspace_box\" :orientation \"h\" \
            (button  :onclick \"hyprctl dispatch workspace 1\"  :class \"$ws1\" \"$icon_ws1 \") \
            (button  :onclick \"hyprctl dispatch workspace 2\"  :class \"$ws2\" \"$icon_ws2 \") \
            (button  :onclick \"hyprctl dispatch workspace 3\"  :class \"$ws3\" \"$icon_ws3 \") \
            (button  :onclick \"hyprctl dispatch workspace 4\"  :class \"$ws4\" \"$icon_ws4 \") \
            (button  :onclick \"hyprctl dispatch workspace 5\"  :class \"$ws5\" \"$icon_ws5 \") \
            (button  :onclick \"hyprctl dispatch workspace 6\"  :class \"$ws6\" \"$icon_ws6 \") \
          ))"
}

workspaces
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r; do
  workspaces
done
