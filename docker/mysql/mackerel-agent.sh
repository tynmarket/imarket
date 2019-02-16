#!/bin/sh

LOGFILE=/mackerel-agent/mackerel-agent.log
PIDFILE=/mackerel-agent/mackerel-agent.pid
ROOT=/mackerel-agent

(
  if [ "${DISABLE_MACKEREL}" = "true" ]; then
    exit 0
  fi

  cd mackerel-agent
  echo 'roles = [ "iMarket:db" ]' >> mackerel-agent.conf
  echo "apikey = \"$MACKEREL_API_KEY\"" >> mackerel-agent.conf
  ./mackerel-agent supervise -conf mackerel-agent.conf --pidfile=$PIDFILE --root=$ROOT >>$LOGFILE 2>&1 &
)
