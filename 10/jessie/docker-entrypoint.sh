#!/bin/sh
set -e

# Openshift: Ensure that assigned uid has entry in /etc/passwd.
if [ `id -u` -ge 10000 ]; then
  cat /etc/passwd | sed -e "s/^node:/builder:/" > /tmp/passwd
  echo "node:x:`id -u`:`id -g`:,,,:/home/node:/bin/bash" >> /tmp/passwd
  cat /tmp/passwd > /etc/passwd
  rm /tmp/passwd
fi

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- node "$@"
fi

exec "$@"
