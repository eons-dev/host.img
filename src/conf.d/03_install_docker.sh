pacman-key --init
pacman-key --populate
pacman -S docker --noconfirm
systemctl enable docker

mkdir -p /guest
touch /guest/image
mkdir -p /root/.config/rclone
touch /guest/rclone
cat << 'EOF' > /etc/systemd/system/hosted.service
[Unit]
Description=Containerized application
After=docker.service

[Service]
Type=exec
ExecStart=bash -c "docker run --network host --privileged --mount type=bind,source=/guest/rclone,target=/root/.config/rclone/rclone.conf,readonly $(cat /guest/image)"
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload #doesn't work in chroot but is harmless
systemctl enable hosted
