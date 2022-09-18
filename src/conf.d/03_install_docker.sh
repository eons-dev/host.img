pacman-key --init
pacman-key --populate
pacman -S docker --noconfirm
systemctl enable docker

mkdir -p /etc/run
touch /etc/run/image
cat << 'EOF' > /etc/systemd/system/hosted.service
[Unit]
Description=Containerized application
After=docker.service

[Service]
Type=exec
ExecStart=docker run --network host --privileged $(cat /etc/run/image)
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload #doesn't work in chroot but is harmless
systemctl enable hosted
