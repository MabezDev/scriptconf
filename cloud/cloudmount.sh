#!/bin/bash

mkdir -p /cloud/gdrive
mkdir -p /cloud/scripts

rclone mount --max-read-ahead 1024k --allow-other root: /cloud/gdrive --config=/home/mabez/.config/rclone/rclone.conf &
rclone mount --max-read-ahead 1024k --allow-other root:Scripts /cloud/scripts --config=/home/mabez/.config/rclone/rclone.conf &