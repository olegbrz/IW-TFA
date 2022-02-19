#!/usr/bin/env bash
# -*- coding: utf-8 -*-

docker start iw
nohup mysql-workbench >/dev/null &

source ./.venv/bin/activate.fish
python3 main.py
