#!/usr/bin/env bash

echo "Starting the Tracking Consent Frontend to enable GA tracking locally..."
sm2 -start TRACKING_CONSENT_FRONTEND

export ENVIRONMENT=local
echo "ENVIRONMENT is set to 'local' to enable GA tracking locally..."

if [[ -z "$1" ]]; then
  SERVER_TYPE="play"
else
  SERVER_TYPE="$1"
fi

if [[ "$#" -gt 1 || ("$SERVER_TYPE" != "middleman" && "$SERVER_TYPE" != "play") ]]; then
  echo "Error: Invalid argument! Only 'middleman' or 'play' is allowed with only one argument supplied. Exiting..."
  exit 1
fi

echo "Starting the $SERVER_TYPE server..."

if [[ "$SERVER_TYPE" == "middleman" ]]; then
  bundle exec middleman server
  exit 0
else
  echo "Running tests to generate static HTML files and store them in the public folder..."
  sbt clean test

  if [[ $? -ne 0 ]]; then
    echo "Error: Tests failed! Exiting..."
    exit 1
  fi

  if [ ! -d "public" ]; then
    echo "Error: Public folder was not generated! Exiting..."
    exit 1
  fi

  echo "Starting Play server and launching the service guide locally..."
  sbt run
fi