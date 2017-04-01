FROM openjdk:8-jdk-alpine

ENV LANG C.UTF-8

RUN apk update && apk add --no-cache bash openssl tar gzip
RUN apk add --no-cache --virtual=build-dependencies curl wget

ARG SCALA_VERSION=2.12.1

ENV SCALA_VERSION ${SCALA_VERSION}

ARG SCALA_URI="https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-${SCALA_VERSION}.tgz"

ENV SCALA_HOME "/usr/lib/scala-${SCALA_VERSION}"

RUN curl $SCALA_URI | tar -xzf- -C /usr/lib && \
    rm -rf $SCALA_HOME/bin/*.bat

RUN chmod -R 755 "$SCALA_HOME" && \
    chown -R root:root "$SCALA_HOME"

RUN apk del build-dependencies

ENV PATH $PATH:$SCALA_HOME/bin
