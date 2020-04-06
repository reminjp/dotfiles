#!/bin/bash

get_os_name() {
  local os_name
  case $(uname | tr '[:upper:]' '[:lower:]') in
    *linux*)
      if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        if [ -e /etc/lsb-release ]; then
          os_name='ubuntu'
        else
          os_name='debian'
        fi
      else
        os_name='linux'
      fi
      ;;
    *darwin*)
      os_name='mac'
      ;;
    *)
      os_name='unknown'
      ;;
  esac
  echo ${os_name}
}
