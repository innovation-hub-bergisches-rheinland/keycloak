FROM maven:3-eclipse-temurin-20-alpine AS theme
RUN mkdir /src
COPY themes /src
WORKDIR /src
RUN mvn clean package

FROM alpine:latest AS extensions

RUN mkdir /src
RUN wget https://github.com/aznamier/keycloak-event-listener-rabbitmq/releases/download/3.0.2/keycloak-to-rabbit-3.0.2.jar -O /src/keycloak-to-rabbit.jar

FROM quay.io/keycloak/keycloak:22.0.1 AS builder

# Quarkus distribution removed the /auth context path. To preserve compatibility with existing
# services we reintroduce it.
ENV KC_HTTP_RELATIVE_PATH=/auth

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

COPY --from=extensions /src /opt/keycloak/providers
COPY --from=theme /src/target /opt/keycloak/providers
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:22.0.1
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
COPY --from=extensions /src /opt/keycloak/providers
COPY --from=theme /src/target /opt/keycloak/providers
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD [ "start" ]
