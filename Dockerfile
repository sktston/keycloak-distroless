FROM quay.io/keycloak/keycloak:latest as base-env

FROM gcr.io/distroless/java:11-nonroot
COPY --chown=nonroot:nonroot --from=base-env /opt/jboss /opt/jboss

ENTRYPOINT [ "java", "-D[Standalone]", "-server", "-Xms64m", "-Xmx512m", "-XX:MetaspaceSize=96M", "-XX:MaxMetaspaceSize=256m", "-Djava.net.preferIPv4Stack=true", "-Djboss.modules.system.pkgs=org.jboss.byteman", "-Djava.awt.headless=true", "--add-exports=java.base/sun.nio.ch=ALL-UNNAMED", "--add-exports=jdk.unsupported/sun.misc=ALL-UNNAMED", "--add-exports=jdk.unsupported/sun.reflect=ALL-UNNAMED", "-Dorg.jboss.boot.log.file=/opt/jboss/keycloak/standalone/log/server.log", "-Dlogging.configuration=file:/opt/jboss/keycloak/standalone/configuration/logging.properties", "-jar", "/opt/jboss/keycloak/jboss-modules.jar", "-mp", "/opt/jboss/keycloak/modules", "org.jboss.as.standalone", "-Djboss.home.dir=/opt/jboss/keycloak", "-Djboss.server.base.dir=/opt/jboss/keycloak/standalone", "-Djboss.bind.address=172.17.0.2", "-Djboss.bind.address.private=172.17.0.2", "-c=standalone-ha.xml" ]
