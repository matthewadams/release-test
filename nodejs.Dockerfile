FROM alpine:3.6

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

COPY ./release-nodejs /scripts/release-nodejs
RUN chmod +x /scripts/release-nodejs
RUN ln -s /scripts/release-nodejs /usr/local/bin/release-nodejs

RUN mkdir /gitrepo
VOLUME [ "/gitrepo" ]
WORKDIR /gitrepo

ENTRYPOINT [ "release-nodejs" ]
CMD [ "--help" ]
