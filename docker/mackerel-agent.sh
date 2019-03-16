#!/bin/sh

LOGFILE=/var/log/mackerel-agent.log
PIDFILE=/var/run/mackerel-agent.pid

if [ "${DISABLE_MACKEREL}" = "true" ]; then
  exit 0
fi

cd mackerel-agent
echo 'roles = [ "iMarket:app" ]' >> mackerel-agent.conf
echo "apikey = \"$MACKEREL_API_KEY\"" >> mackerel-agent.conf
./mackerel-agent supervise -conf mackerel-agent.conf --pidfile=$PIDFILE >>$LOGFILE 2>&1 &
