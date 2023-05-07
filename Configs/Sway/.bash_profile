
# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec dbus-launch --sh-syntax --exit-with-session sway

# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

GUIX_PROFILE="/home/carmen/.guix-profile"
     . "$GUIX_PROFILE/etc/profile"
export XDG_RUNTIME_DIR

if [ -e /home/carmen/.nix-profile/etc/profile.d/nix.sh ]; then . /home/carmen/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

#if [ "$XDG_SESSION_TYPE" = "x11" ]; then 
#    synclient VertScrollDelta=-77
#    synclient HorizScrollDelta=-77
#    synclient HorizTwoFingerScroll=1
#    synclient TapButton1=1
#fi
# Update test for softlinking


#syndaemon -i 0.8 -d -R
# Does this turn on shepherd?
shepherd

