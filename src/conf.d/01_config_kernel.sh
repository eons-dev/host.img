cat <<EOF | sudo tee /etc/modules-load.d/netfilter.conf
overlay
br_netfilter
EOF

# Not possible from chroot?
# modprobe overlay
# modprobe br_netfilter

cat << EOF >> /etc/sysctl.conf
net.ipv4.ip_nonlocal_bind=1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl -p