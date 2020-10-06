#!/bin/sh
RUN_DIR=`pwd`
cd ../appserver/waterworks
docker-compose down
docker system prune -f
sleep 1
docker-compose up -d
docker-compose logs -f waterworks-server
cd $RUN_DIR
