#!/bin/bash
# Install Maven, a build tool for building and managing any Java-based project - https://maven.apache.org/
# manual installation taken from https://maven.apache.org/install.html
#
# Include in your builds via
# \curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/sbt.sh | bash -s
MAVEN_VERSION=${MAVEN_VERSION:="3.3.9"}
MAVEN_DIR=${ELASTICSEARCH_DIR:="$HOME/maven"}
MAVEN_URL="http://apache.mirrors.tds.net/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"

set -e

CACHED_DOWNLOAD="${HOME}/cache/maven-${MAVEN_VERSION}.tar.gz"

mkdir -p "${ELASTICSEARCH_DIR}"
wget --continue --output-document "${CACHED_DOWNLOAD}" "${MAVEN_URL}"
tar -xaf "${CACHED_DOWNLOAD}" --strip-components=1 --directory "${MAVEN_DIR}"

# Make sure to use the exact parameters you want for ElasticSearch and give it enough sleep time to properly start up
nohup bash -c "${ELASTICSEARCH_DIR}/bin/elasticsearch 2>&1" &
sleep "${ELASTICSEARCH_WAIT_TIME}"
