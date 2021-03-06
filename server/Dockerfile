FROM openjdk:14 AS binaries
RUN yum install unzip -y

# Download and install Gradle
RUN \
    cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-6.3-bin.zip -o gradle-6.3-bin.zip && \
    unzip gradle-6.3-bin.zip && \
    rm gradle-6.3-bin.zip


FROM binaries AS dependencies
ENV GRADLE_HOME=/usr/local/gradle-6.3
ENV GRADLE_USER_HOME=/gradle-dependencies
ENV PATH=$PATH:$GRADLE_HOME/bin

ADD . /source

FROM dependencies AS builder
RUN \ 
  cd /source && \
  gradle clean build

# Define default command.
FROM openjdk:14-alpine AS app
WORKDIR /app
COPY --from=builder /source/build/libs/server-0.0.1-SNAPSHOT.jar ./app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]