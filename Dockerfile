FROM openjdk:8-jdk-alpine

ENV LANG C.UTF-8

RUN apk update && apk add --no-cache openssl tar gzip
RUN apk add --no-cache --virtual=build-dependencies curl

ARG SCALA_VERSION=2.11.8

ARG SCALA_URI="https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz"

ENV SCALA_HOME "/usr/lib/scala-$SCALA_VERSION"

RUN curl -sL -# $SCALA_URI | tar -xzf- -C /usr/lib && \
    rm -rf $SCALA_HOME/bin/*.bat

RUN chmod -R 755 "$SCALA_HOME" && \
    chown -R root:root "$SCALA_HOME"

RUN apk del build-dependencies

ENV PATH $PATH:$SCALA_HOME/bin
