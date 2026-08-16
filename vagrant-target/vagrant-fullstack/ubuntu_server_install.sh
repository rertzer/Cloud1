#! /bin/sh

if [ -e /home/vagrant/.ubuntu_install_done ]; then
	echo "ubuntu install already done"
	exit
else
	echo "ubuntu install"
	sed -i 's/addresses:.*/addresses: 10.0.2.3/' /etc/netplan/01-netcfg.yaml
	sed -i 's/^DNS=/#DNS=/' /etc/systemd/resolved.conf

	netplan generate
	netplan apply
	systemctl restart systemd-resolved
	sleep 4
	resolvectl flush-caches
	touch /home/vagrant/.ubuntu_install_done
fi
