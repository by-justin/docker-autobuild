#!/bin/bash

while [ true ]; do
  sleep 30
  curl -x "http://0.0.0.0:9910" "https://google.com" > /dev/null
done