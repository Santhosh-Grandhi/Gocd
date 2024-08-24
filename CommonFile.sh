Heading() {
  echo -e "\e[35m$*\e[0m"
}

STAT() {
  if [ "$1" -eq 0 ]; then
    echo Success
  else
    echo Failed
    exit 2
    fi
   }

