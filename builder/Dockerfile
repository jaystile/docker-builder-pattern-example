FROM openjdk:14 

RUN yum install unzip -y

# Download and install Gradle
RUN \
    cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-6.3-bin.zip -o gradle-6.3-bin.zip && \
    unzip gradle-6.3-bin.zip && \
    rm gradle-6.3-bin.zip

# Export some environment variables
ENV GRADLE_HOME=/usr/local/gradle-6.3
ENV GRADLE_USER_HOME=/gradle-dependencies
ENV PATH=$PATH:$GRADLE_HOME/bin
ENV SOURCE_DIR=/source
ENV BUILD_DIR=/build

# Define default command.
COPY ./preflight.sh /
COPY ./build.sh /
CMD ["bash"]