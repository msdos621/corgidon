FROM hoteltonight/ruby-jemalloc:2.5.1-stretch

LABEL maintainer="https://github.com/tootsuite/mastodon" \
      description="Your self-hosted, globally interconnected microblogging community"

ARG UID=991
ARG GID=991

ENV PATH=/mastodon/bin:$PATH \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_ENV=production \
    NODE_ENV=production

EXPOSE 3000 4000

WORKDIR /mastodon

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update  -qqy \
 && apt-get install -qqy libicu-dev libidn11-dev libprotobuf-dev protobuf-compiler ffmpeg nodejs yarn \
 && cd /mastodon \
 && rm -rf /tmp/* /var/cache/apk/* /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock package.json yarn.lock .yarnclean /mastodon/

RUN bundle install -j$(getconf _NPROCESSORS_ONLN) --deployment --without test development \
 && yarn install --pure-lockfile --ignore-engines \
 && yarn cache clean

RUN groupadd -g ${GID} mastodon && useradd -s /bin/sh -d /mastodon -u ${UID} -g mastodon mastodon
RUN mkdir -p /mastodon/public/system /mastodon/public/assets /mastodon/public/packs
RUN chown -R mastodon:mastodon /mastodon/public

COPY . /mastodon

RUN chown -R mastodon:mastodon /mastodon

VOLUME /mastodon/public/system

USER mastodon

RUN OTP_SECRET=precompile_placeholder SECRET_KEY_BASE=precompile_placeholder bundle exec rails assets:precompile

ENTRYPOINT ["/sbin/tini", "--"]
