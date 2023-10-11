if id=$(xdo id -N kittyToggle)>/dev/null 2>&1; then
    bspc node $id -g hidden && echo "Window hidden successfully."
    bspc node -f $id
    echo "Sucess: Window found! ID: - $id"
else
    echo "Error: Window not found."
fi

