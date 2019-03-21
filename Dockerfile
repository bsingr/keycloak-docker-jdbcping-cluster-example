FROM quay.io/keycloak/keycloak:5.0.0

# root is needed for
# - for installing certs 
# - for fixing permissions after copying files (docker uses root for copying files anyway)
USER root

# our realms (will be imported through envvar)
COPY realms /opt/jboss/realms
ENV KEYCLOAK_IMPORT /opt/jboss/realms/example.json

# Add module
COPY vendor/modules/ /opt/jboss/modules/

# TODO don't know if we need this actually
COPY configuration/jgroups-module.xml ${JBOSS_HOME}/modules/system/layers/base/org/jgroups/main/module.xml

# add customized tools (docker-entrypoint.sh and jgroups configuration cli)
COPY tools /opt/jboss/tools
COPY startup-scripts /opt/jboss/startup-scripts

RUN chown -R jboss:jboss \
  /opt/jboss/realms \
  /opt/jboss/modules \
  /opt/jboss/tools \
  /opt/jboss/startup-scripts

USER jboss

# 8080 = keycloak, 7600 = jdbc_ping
# as of 20190312 we can't set the port for jdbc_ping dynamically/different on each container
EXPOSE 8080 7600

ENTRYPOINT [ "/opt/jboss/tools/entrypoint.sh" ]
