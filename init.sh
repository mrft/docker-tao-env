#!/bin/sh

NGINX_PORT=80

if [ $1 ]; then
    NGINX_PORT=$1
fi

PROJECT_NAME=`basename "$PWD"`

TAO_VOLUME_PATH='./docker_volumes/tao'
NGINX_VOLUME_PATH='./docker_volumes/web'

mkdir -m 0755 -p "${NGINX_VOLUME_PATH}"
mkdir -m 0755 -p "${TAO_VOLUME_PATH}/var_www_html"
cp info.php "${TAO_VOLUME_PATH}/var_www_html"


# Using | instead of / because $PWD contains /'s
sed "	s|PROJECT_ROOT_VALUE|$PWD|g 
	s|PROJECT_NAME_VALUE|$PROJECT_NAME|g" nginx-proxy.conf.template > ${TAO_VOLUME_PATH}/nginx-proxy.conf
sed "s|PROJECT_NAME_VALUE|$PROJECT_NAME|g" nginx.conf.template > ${NGINX_VOLUME_PATH}/nginx.conf
sed "	s|NGINX_PORT=80|NGINX_PORT=$NGINX_PORT|g
	s|PROJECT_NAME_VALUE|$PROJECT_NAME|g" .env.template > ${TAO_VOLUME_PATH}/.env
