#!/bin/bash

ifconfig | grep '192.168.1.' | grep -v 'broadcast 0.0.0.0' | awk -F ' ' '{print $2}'