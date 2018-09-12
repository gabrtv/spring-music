FROM gradle:jdk8 as builder

LABEL maintainer="gabe.monroy@microsoft.com"

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

FROM openjdk:8-jre
COPY --from=builder /home/gradle/src/build/libs/src-1.0.jar /usr/src/myapp/spring-music.jar
EXPOSE 8080
WORKDIR /usr/src/myapp
CMD ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "spring-music.jar"]
