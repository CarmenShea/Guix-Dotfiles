Main Sway config file: 
This is launched from TTY1, you will also need to have
a .bash_profile located in ~/
Sway will auto launch when the user logs into the TTY1. The first file read from TTY1 will be the 
.bash_profile which contains the launch line for sway and includes the D_Bus launcher.

The main Sway config file is put in ~/.config/sway
The bash_profile file needs to be renamed to .bash_profile before copying to ~/
