#!/bin/sh
echo "==== START ===="

# umask
echo ">>> set umask..."
umask=$UMASK
umask $umask
if [ $? -ne 0 ]; then
    echo "umask set failed, please check the umask value $umask, exit"
    exit 1
else
    echo "umask set to $umask"
fi
echo ">>> set umask success"

# log level
echo ">>> set deluge log level..."
loglevel=$LOG_LEVEL
echo "log level set to $loglevel"
echo ">>> set deluge log level success"

# prepare
echo ">>> prepare files..."
mkdir -p /log
mkdir -p /config
mkdir -p /downloads
echo ">>> prepare files success"

# deluge-web
echo ">> start deluge web interface..."
echo "deluge-web version:"
/usr/local/bin/deluge-web --version
/usr/local/bin/deluge-web -l /log/web.log -L $loglevel --logrotate 1M -p 8080 --config /config
if [ $? -ne 0 ]; then
    echo "start deluge web interface failed, exit"
    exit 1
fi
echo ">> start deluge web interface success"

# deluged
echo ">>> start deluge daemon..."
echo "deluged version:"
/usr/local/bin/deluged --version
/usr/local/bin/deluged -d -l /log/daemon.log -L $loglevel --logrotate 1M --config /config
echo "==== END ===="
