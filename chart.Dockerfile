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

COPY ./release-chart /scripts/release-chart
RUN chmod +x /scripts/release-chart
RUN ln -s /scripts/release-chart /usr/local/bin/release-chart

RUN mkdir /gitrepo
VOLUME [ "/gitrepo" ]
WORKDIR /gitrepo

ENTRYPOINT [ "release-chart" ]
CMD [ "--help" ]
