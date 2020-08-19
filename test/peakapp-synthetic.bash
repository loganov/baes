#!/bin/bash

# ```docker run -p 8080:5000 skippy```
# curl -Is http://localhost:8080 | head -n 1

HIT=$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8080)
  if [ $HIT -eq 200 ]; then
    echo "Success: 200"
  else
    echo "Failure: $HIT"
  fi
