FROM alpine:3.8

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
      bash \
      git \
      openssh \
      nodejs \
      npm

RUN npm i -g npm
RUN npm i -g ymlx

RUN mkdir /scripts
COPY ./match /scripts/match
RUN chmod +x /scripts/match
RUN ln -s /usr/local/bin/match /scripts/match

COPY ./release-docker-image-codefresh /scripts/release-docker-image-codefresh
RUN chmod +x /scripts/release-docker-image-codefresh
RUN ln -s /usr/local/bin/release-docker-image-codefresh /scripts/release-docker-image-codefresh

RUN mkdir /gitrepo
VOLUME [ "/gitrepo" ]
WORKDIR /gitrepo

ENTRYPOINT [ "release-docker-image-codefresh" ]
CMD [ "--help" ]
