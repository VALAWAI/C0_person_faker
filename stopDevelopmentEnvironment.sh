#!/bin/bash
if [ -f /.dockerenv ]; then
   echo "You can not stop the development environment inside a docker container"
else
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	pushd $DIR >/dev/null
	docker-compose -f src/dev/docker/docker-compose.yml down
	if [ "$(docker container ls |grep c0_person_faker_dev |wc -l)" -gt "0" ]
	then
		docker stop c0_person_faker_dev
	fi
	popd >/dev/null
fi