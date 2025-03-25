#!/bin/sh

url="https://www.toptal.com/developers/gitignore/api/python"

if command -v curl >/dev/null 2>&1; then
  curl -s "$url" >> .gitignore
  echo "The .gitignore file has been successfully updated!"
else
  echo "Error: curl command is not installed."
  exit 1
fi

