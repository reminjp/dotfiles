#!/bin/bash

get_os_name() {
  case $(uname | tr '[:upper:]' '[:lower:]') in
    *linux*)
      if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        if [ -e /etc/lsb-release ]; then
          declare -r OS_NAME='ubuntu'
        else
          declare -r OS_NAME='debian'
        fi
      else
        declare -r OS_NAME='linux'
      fi
      ;;
    *darwin*)
      declare -r OS_NAME='mac'
      ;;
    *)
      declare -r OS_NAME='unknown'
      ;;
  esac
  echo ${os_name}
}
