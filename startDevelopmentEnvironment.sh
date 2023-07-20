#!/bin/bash
if [ -f /.dockerenv ]; then
   echo "You can not start the development environment inside a docker container"
else
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	pushd $DIR >/dev/null
	DOCKER_ARGS=""
	if [ "no-cache" = "$1" ];
	then
		DOCKER_ARGS="$DOCKER_ARGS --no-cache"
		if [ -e .env ];
		then
			source .env
		fi
	fi
	DOCKER_BUILDKIT=1 docker build $DOCKER_ARGS -f src/dev/docker/Dockerfile -t valawai/c0_person_faker:dev .
	if [ $? -eq 0 ]; then
		docker-compose -f src/dev/docker/docker-compose.yml up -d
		DOCKER_PARAMS="--rm --name c0_person_faker_dev --add-host=host.docker.internal:host-gateway -v /var/run/docker.sock:/var/run/docker.sock -p 5005:5005 -it"
		if [[ "$OSTYPE" == "darwin"* ]]; then
			DOCKER_PARAMS="$DOCKER_PARAMS -e TESTCONTAINERS_HOST_OVERRIDE=docker.for.mac.host.internal"
		fi
		docker run $DOCKER_PARAMS -v "${HOME}/.m2":/root/.m2  -v "${PWD}":/app valawai/c0_person_faker:dev /bin/bash
		./stopDevelopmentEnvironment.sh
	fi
	popd >/dev/null
fi
