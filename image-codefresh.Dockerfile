FROM alpine:3.8

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
      bash \
      git \
      openssh \
      nodejs \
      npm

RUN npm i -g ymlx

RUN mkdir /scripts
COPY ./match /scripts/match
RUN chmod +x /scripts/match
RUN ln -s /scripts/match /usr/local/bin/match

COPY ./release-image-codefresh /scripts/release-image-codefresh
RUN chmod +x /scripts/release-image-codefresh
RUN ln -s /scripts/release-image-codefresh /usr/local/bin/release-image-codefresh

RUN mkdir /gitrepo
VOLUME [ "/gitrepo" ]
WORKDIR /gitrepo

ENTRYPOINT [ "release-image-codefresh" ]
CMD [ "--help" ]
