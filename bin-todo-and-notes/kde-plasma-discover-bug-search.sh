
exit 1

# https://discuss.kde.org/t/plasma-discover-not-launching/12503/21

plasma-discover

killall plasma-discover
plasma-discover
plasma-discover --listbackends
plasma-discover --backends packagekit-backend
plasma-discover --backends snap-backend
plasma-discover --backends kns-backend
plasma-discover --backends fwupd-backend

killall plasma-discover
plasma-discover --listbackends
plasma-discover --backends packagekit-backend,snap-backend,kns-backend
plasma-discover --backends packagekit-backend,snap-backend
plasma-discover --backends snap-backend
plasma-discover --backends snap-backend,packagekit-backend
plasma-discover --backends snap-backend,packagekit-backend,fwupd-backend
plasma-discover --backends snap-backend,packagekit-backend,kns-backend
