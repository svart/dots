#!/bin/bash

flock --nonblock /tmp/.wofi.lock wofi $1
