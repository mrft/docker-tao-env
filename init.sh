#!/bin/sh

NGINX_PORT=80

if [ $1 ]; then
    NGINX_PORT=$1
fi

PROJECT_NAME=`basename "$PWD"`

# Using | instead of / because $PWD contains /'s
sed "	s|PROJECT_ROOT_VALUE|$PWD|g 
	s|PROJECT_NAME_VALUE|$PROJECT_NAME|g" nginx-proxy.conf.template > nginx-proxy.conf
sed "s|PROJECT_NAME_VALUE|$PROJECT_NAME|g" nginx.conf.template > nginx.conf
sed "	s|NGINX_PORT=80|NGINX_PORT=$NGINX_PORT|g
	s|PROJECT_NAME_VALUE|$PROJECT_NAME|g" .env.template > .env
