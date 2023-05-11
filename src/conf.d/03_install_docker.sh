pacman-key --init
pacman-key --populate
pacman -S docker --noconfirm
systemctl enable docker

mkdir -p /guest
mkdir /guest/rclone
touch /guest/image
touch /guest/name
export GUEST=$(cat /guest/name)
mkdir -p /tmp/$GUEST/tmp
mkdir -p /tmp/$GUEST/var/lib/containerd
mkdir -p /tmp/$GUEST/run/containerd

cat << 'EOF' > /etc/systemd/system/hosted.service
[Unit]
Description=Containerized application
After=docker.service

[Service]
Type=exec
ExecStart=bash -c "docker run --cgroupns=host --privileged -h $GUEST --rm -it --network host --entrypoint /bin/bash -v /guest/rclone:/root/.config/rclone -v /lib/modules:/lib/modules -v /tmp/$GUEST/tmp:/tmp -v /tmp/$GUEST/var/lib/containerd:/var/lib/containerd -v /tmp/$GUEST/run/containerd:/run/containerd $(cat /guest/image)"
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload #doesn't work in chroot but is harmless
systemctl enable hosted
