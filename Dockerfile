FROM ruby:3.0-slim

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV APP_ROOT /app
ENV RACK_ENV production

RUN set -ex \
  && apt-get update \
  && apt-get install -y build-essential git

RUN mkdir -p ${APP_ROOT}
WORKDIR ${APP_ROOT}

COPY Gemfile* ${APP_ROOT}/
RUN bundle install

COPY . ${APP_ROOT}

# CMD ["bundle", "exec", "ruby", "app.rb"]
CMD ["bash", "-c", "rackup --port=${PORT:-4567} --host=0.0.0.0"]
