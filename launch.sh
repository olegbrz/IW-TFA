#!/usr/bin/env bash
# -*- coding: utf-8 -*-

nohup docker start iw >/dev/null &
nohup mysql-workbench >/dev/null &

source ./.venv/bin/activate.fish
python3 main.py
