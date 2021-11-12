#!/bin/bash

tee -a /etc/systemd/system/thermal-log.service > /dev/null <<EOT
[Unit]
Description=Pulses Thermal Logging 

[Service]
Type=simple
Restart=always
TimeoutStopSec=40s
SendSIGKILL=yes
RestartSec=90s
WorkingDirectory=/var/log
ExecStart=/lib/pulses/utils/temp.sh

[Install]
WantedBy=default.target
EOT
systemctl enable thermal-log.service