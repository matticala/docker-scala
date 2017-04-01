FROM openjdk:8-jdk-alpine

ENV LANG C.UTF-8

ARG SCALA_VERSION=2.12.1
ARG SBT_VERSION=0.13.13

ENV SCALA_VERSION ${SCALA_VERSION}
ENV SBT_VERSION ${SBT_VERSION}

ENV SCALA_HOME "/usr/lib/scala-$SCALA_VERSION"
ENV SBT_HOME "/usr/share/sbt-$SBT_VERSION"

RUN apk update && apk add --no-cache bash openssl
RUN apk add --no-cache --virtual=build-dependencies curl

RUN curl "https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz" | tar -xzf- -C /usr/lib && \
    rm -rf $SCALA_HOME/bin/*.bat
RUN curl -sL "https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar -xzf- -C /usr/share && \
    mv "/usr/share/sbt-launcher-packaging-$SBT_VERSION" "$SBT_HOME" && \
    rm -rf "$SBT_HOME/bin/*.bat"

RUN chmod -R 755 "$SCALA_HOME" "$SBT_HOME" && \
    chown -R root:root "$SCALA_HOME" "$SBT_HOME"

RUN apk del build-dependencies

ENV PATH $PATH:$SCALA_HOME/bin:$SBT_HOME/bin
