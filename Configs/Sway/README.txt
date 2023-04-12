Main Sway config file, this is launched from TTY1, you will also need to have
a .bash_profile located in ~/
Sway will auto launch when the user logs into the TTY1. The first file read from TTY1 will be the 
.bash_profile which contains the launch line for sway and includes the D_Bus launcher.

The main Sway config file is located in ~/.config/sway
