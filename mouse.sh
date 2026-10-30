cat << 'EOF' > ~/set_mouse_macro.sh
#!/bin/bash

# 1. Создаем папку для скриптов и сам файл макроса приседания
mkdir -p ~/.local/bin
cat << 'INNER_EOF' > ~/.local/bin/cs_duck.sh
#!/bin/bash
xdotool keydown ctrl
sleep 0.02
xdotool keyup ctrl
INNER_EOF

# Делаем скрипт приседания исполняемым
chmod +x ~/.local/bin/cs_duck.sh

# 2. Создаем или перезаписываем конфигурационный файл xbindkeys под 8-ю кнопку
# b:8 означает Button 8 (8-я кнопка мыши по определению xev)
cat << 'INNER_EOF' > ~/.xbindkeysrc

# Макрос для приседания в CS 1.6 на 8-ю кнопку мыши
"~/.local/bin/cs_duck.sh"
  b:8
INNER_EOF

# 3. Добавляем xbindkeys в автозагрузку Ubuntu
mkdir -p ~/.config/autostart
cat << 'INNER_EOF' > ~/.config/autostart/xbindkeys.desktop
[Desktop Entry]
Type=Application
Exec=xbindkeys
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Xbindkeys Mouse Macro
Comment=Запуск макросов мыши
INNER_EOF

# Перезапускаем сервис xbindkeys, чтобы применить новые настройки прямо сейчас
killall xbindkeys 2>/dev/null
xbindkeys

echo "✅ Настройка успешно завершена! 8-я кнопка мыши теперь активирует приседание."
EOF

# Делаем установщик исполняемым и запускаем его
chmod +x ~/set_mouse_macro.sh
~/set_mouse_macro.sh
