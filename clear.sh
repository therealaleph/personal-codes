#!/bin/bash
sudo apt update
sudo apt install -y sqlite3
sqlite3 /etc/x-ui/x-ui.db "DELETE FROM inbounds;" "VACUUM;" ".exit"
