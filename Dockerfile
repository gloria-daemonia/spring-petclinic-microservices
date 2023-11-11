FROM maven:3.8.5-openjdk-17 as builder
# spring-petclinic-api-gateway
ARG SERVICE_NAME
COPY pom.xml pom.xml
COPY ${SERVICE_NAME} ${SERVICE_NAME} 
WORKDIR ${SERVICE_NAME}
RUN mvn package

FROM openjdk:17-alpine
ARG SERVICE_NAME
ENV SERVICE=${SERVICE_NAME}
COPY --from=builder ${SERVICE_NAME}/target/${SERVICE_NAME}*.jar ${SERVICE_NAME}.jar
EXPOSE $PORT
ENTRYPOINT ["sh", "-c", "java -jar $SERVICE.jar"]
# CMD ["-Dcustom.var1=$var1", "-Dcustom.var2=$var2"]