#!/bin/bash

exec /sbin/setuser nobody python /opt/moviegrabber/MovieGrabber.py --config /config/config --db /config/db --logs /config/logs
