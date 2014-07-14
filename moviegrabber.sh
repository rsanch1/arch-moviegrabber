#!/bin/bash

exec /sbin/setuser nobody python2.7 /opt/moviegrabber/moviegrabber-master/MovieGrabber.py --config /config/config --db /config/db --logs /config/logs
