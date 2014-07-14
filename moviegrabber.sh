#!/bin/bash

exec /sbin/setuser nobody python /opt/moviegrabber/moviegrabber-master/MovieGrabber.py --config /config/config --db /config/db --logs /config/logs
