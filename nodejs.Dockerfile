FROM alpine:3.6

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
COPY ./release-nodejs /scripts/release-nodejs
RUN chmod +x /scripts/release-nodejs

RUN mkdir /gitrepo
VOLUME [ "/gitrepo" ]

WORKDIR /gitrepo

ENTRYPOINT [ "/scripts/release-nodejs" ]
CMD [ "--help" ]
