#!/bin/sh
#
# anrxc's X.org init file on Arch GNU/Linux


# Log settings
#
errorlog="$HOME/.xsession-errors"
#
# Start with a clean log file every time
if ( cp /dev/null "$errorlog" 2> /dev/null ); then
     chmod 600 "$errorlog"
     exec > "$errorlog" 2>&1
fi


# Environment settings
# 
# Somewhat nicer OpenOffice than with QT style
#export OOO_FORCE_DESKTOP="gnome"
#
# Disable Pango in Gecko, performance wise
export MOZ_DISABLE_PANGO=1

export BROWSER=/usr/bin/firefox

# Force Xft for old GNOME and QT applications
export GDK_USE_XFT=1
export QT_XFT=true

# Resource and keymap settings
#
usermodmap=$HOME/.Xmodmap
userresources=$HOME/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
# 
# Merge system and user resources and keymaps
if [ -f $sysresources ]; then
    /usr/bin/xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    /usr/bin/xmodmap $sysmodmap
fi
if [ -f $userresources ]; then
    /usr/bin/xrdb -merge $userresources
fi
if [ -f $usermodmap ]; then
    /usr/bin/xmodmap $usermodmap
fi


# Input settings
#
# Keyboard control, repeat delay and repeat rate
#/usr/bin/xset r rate 200 30
#
# Pointer control, acceleration and threshold
#/usr/bin/xset m 30/10 4
#
# Fix broken (HAL) key mappings
#  - Lock key
#/usr/bin/sudo /usr/bin/setkeycodes e06e 152
#  - Presentation key
#/usr/bin/sudo /usr/bin/setkeycodes e075 217
#  - Sync key
#/usr/bin/sudo /usr/bin/setkeycodes e079 173
#  - Euro key
#/usr/bin/sudo /usr/bin/setkeycodes e033 159
#  - Dollar key
#/usr/bin/sudo /usr/bin/setkeycodes e034 151


# Display settings

# dirty hack to fix JVM (believe you are running a different window manager)
wmname LG3D

# Brightness level
#   - brightness keeps resetting to it's max value after dpms or suspend
#     - fixed in xorg-server 1.6.1
#   - xbacklight can't be used with legacy control, so set level first
#/usr/bin/xbacklight -set 10
 
# Legacy control solves resetting brightness levels
#   - fixed in xorg-server 1.6.1
#   - further changing trough ACPI/acer-wmi (which includes Fn+BrUp/Dn)
#/usr/bin/xrandr --output LVDS --set BACKLIGHT_CONTROL legacy

# Ignore reported display size and force DPI
#/usr/bin/xrandr --dpi 96

# Force LVDS as the primary screen
#/usr/bin/xrandr --output LVDS --primary


# Autostart settings
#
# Start the GnuPG agent and enable the OpenSSH agent emulation
#eval "$(/usr/bin/killall gpg-agent & /usr/bin/gpg-agent --enable-ssh-support --daemon)"

# Play a startup sound
#/usr/bin/ogg123 -q $HOME/.config/awesome/themes/borealis.ogg &

# Set the wallpaper(s) for all screens
#   - awesome 3 calls nitrogen now
#/usr/bin/nitrogen --restore &
#
# Preload KDE daemons
#/usr/bin/kdeinit4 &
# 
# Systray if needed 
#   - awesome 3 has it's own systray
#   - stalone can't be smaller then 24 pixels, doesn't fit at the end of my 14px statusbar
#   - trayer can be resized to 14px and so fit in nicely, but some KDE apps refuse to dock if it's smaller than 16px
#/usr/bin/stalonetray -bg '#1a1a1a' -geometry 124x24+1156+776 --sticky --window-layer top &
#/usr/bin/trayer --edge top --align right --widthtype pixel --heighttype pixel --height 16 \
# --width 70 --expand false --transparent true --alpha 0 --tint 0x3f3f3f &
# 
# Start the GNU Emacs (23) daemon
#/usr/bin/emacs --daemon

# Xwrits reminds you to take wrist breaks and avoid RSI
#/usr/bin/xwrits typetime=40 clock breakclock top \
# ready-picture=$HOME/.xwrits/ready.gif rest-picture=$HOME/.xwrits/rest.gif warning-picture=$HOME/.xwrits/warning.gif &

#pulseaudio

# Open a terminal emulator on the first tag
#   - resume the old screen session or start a new one
#/usr/bin/urxvt -e screen -U -l -S term -D -R &

# Set wallpapper
#awsetbg -f Pictures/wide-wallpaper-1920x1200-111.jpg &

# Start rxvt-unicode daemon
#/usr/bin/urxvtd -q -f -o

# MOC Player Daemon
#mocp -S

# Alsa mixer
/usr/bin/amixer set Master 75% unmute
/usr/bin/amixer set PCM 50% unmute

# Some stuff
/usr/bin/setxkbmap -layout "us,ru"
/usr/bin/setxkbmap -option
/usr/bin/setxkbmap -option "compose:ralt"
/usr/bin/setxkbmap -option "grp:caps_toggle"
/usr/bin/setxkbmap -option "grp_led:caps"

# enable tap to click (2 fingers for middle click, 3 fingers for right click)
synclient TapButton1=1 TapButton2=3 TapButton3=2

# PulseAudio systray 
/usr/bin/pasystray &

# Google Drive
/opt/thefanclub/grive-tools/grive-indicator &

# Feature-rich dictionary lookup program
#goldendict >/dev/null &

# keyboard layout switcher/indicator
#/usr/bin/xxkb &

# Fork of parcellite
#parcellite &
#clipit &

#caffeine &
#xautolock -time 10 -locker "gnome-screensaver-command --lock" &
#/opt/thefanclub/grive-tools/grive-indicator &

#firefox >/dev/null &

#eval `/usr/bin/ssh-agent`
#if [ -f /usr/lib/openssh/x11-ssh-askpass ]; then
#	SSH_ASKPASS=/usr/lib/openssh/x11-ssh-askpass ssh-add < /dev/null
#else
#	SSH_ASKPASS=/usr/bin/ssh-askpass ssh-add < /dev/null
#fi

# Window manager selection
#
#case $1 in
#  twm)
#      exec twm
#      ;;
#  fvwm)
#      exec fvwm2
#      ;;
#  kde)
#      exec startkde
#      ;;
#  *)
#      exec awesome
#      ;;
#esac
