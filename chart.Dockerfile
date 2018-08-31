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

RUN mkdir /scripts
COPY ./release-chart /scripts/release-chart
RUN chmod +x /scripts/release-chart

RUN mkdir /gitrepo
VOLUME [ "/gitrepo" ]

WORKDIR /gitrepo

ENTRYPOINT [ "/scripts/release-chart" ]
CMD [ "--help" ]
