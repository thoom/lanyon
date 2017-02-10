FROM nginx:alpine
MAINTAINER Z. d. Peacock <zdp@thoomtech.com>

RUN apk add --no-cache --update --virtual .build-deps \
    gcc \
    musl-dev \
    linux-headers \
    make \
    ruby-dev \
    libffi-dev \
    && apk add --no-cache --update \
    openssh-client \
    git \
    ruby \
    tini \
    && mkdir -p /etc/nginx \
    && mkdir -p /var/www/app \
    && gem install -N jekyll io-console json bundler \
    && apk del .build-deps

# nginx site conf
RUN rm -Rf /var/www/* \
    && mkdir /var/www/html/

ADD conf/nginx-site.conf /etc/nginx/conf.d/default.conf

# Add Scripts
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

# copy in code
ADD src/ /var/www/html/

EXPOSE 80
ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["sh", "/start.sh"]
