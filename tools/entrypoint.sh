#!/bin/bash -e

# to be able to communicate via JGroups in EC2 Dockerized environment (e.g. ElasticBeanstalk, we need the hostname from the running instance, see also JDBC_PING.cli, we do this via the EC2 meta-data service, available in every EC2 instance)
if [ "$JGROUPS_DISCOVERY_PROTOCOL" != "" ]; then
  # export JGROUPS_NODE_HOSTNAME=${JGROUPS_NODE_HOSTNAME:-$(curl --max-time 5 http://169.254.169.254/latest/meta-data/local-hostname)}
  SYS_PROPS+=" -Djboss.node.name=$JGROUPS_NODE_HOSTNAME"
fi

exec /opt/jboss/tools/docker-entrypoint.sh $SYS_PROPS $@
exit $?
