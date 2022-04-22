
# Some lines to make vscode authentication works on opensuse with kde5
# install gnome-keyring-daemon and seahorse before
# creat a new keyring with seahorse before use this code
# must be used before call vscode
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
