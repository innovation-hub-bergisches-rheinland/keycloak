FROM maven:3-alpine as theme
RUN mkdir /src
COPY themes /src
WORKDIR /src
RUN mvn clean package 

FROM alpine:latest as extensions

RUN mkdir /src
RUN wget https://github.com/aznamier/keycloak-event-listener-rabbitmq/releases/download/3.0.2/keycloak-to-rabbit-3.0.2.jar -O /src/keycloak-to-rabbit.jar
RUN wget https://github.com/Archi-Lab/archilab-keycloak/raw/master/context/themes/target/prox-keycloak-themes.jar -O /src/prox-keycloak-themes.jar

FROM quay.io/keycloak/keycloak:20.0.2 as builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

COPY --from=extensions /src /opt/keycloak/providers
COPY --from=theme /src/target /opt/keycloak/providers
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:20.0.2
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
COPY --from=extensions /src /opt/keycloak/providers
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD [ "start" ]