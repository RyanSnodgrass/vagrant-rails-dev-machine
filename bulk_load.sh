#!/usr/bin/env bash


read -r -p "Would you like to bulk load your database? [y/n] " response

echo $response

if [ $response = y ]; then
  curl -H "Content-Type: application/json" --data @terms.json http://localhost:3000/bulk?admin=true > log.text 
  echo "Your data has been loaded and your environment is ready."
else
  echo "Your environment is ready."
fi
