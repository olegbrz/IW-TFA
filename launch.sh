#!/usr/bin/env bash
# -*- coding: utf-8 -*-

nohup docker start iw >/dev/null &
nohup mysql-workbench >/dev/null &
