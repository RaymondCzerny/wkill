#!/bin/bash

if [ ! $UID -eq 0 ]; then
    sudo $0
    exit
fi

SCRIPT=/usr/local/bin/wkill

cat > $SCRIPT << EOF
#!/usr/bin/python3

import dbus

bus = dbus.SessionBus()

destination = "org.kde.kglobalaccel"
object_path = "/component/kwin"
interface = "org.kde.kglobalaccel.Component"

proxy = bus.get_object(destination, object_path)
method = dbus.Interface(proxy, interface)

method.invokeShortcut("Kill Window")

EOF

chmod +x $SCRIPT
