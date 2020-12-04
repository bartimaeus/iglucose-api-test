FROM ruby:2.6.3-alpine3.10
LABEL maintainer="Eric Shelley <eric@webdesignbakery.com>"

### Development environment customizations ###
RUN echo "export PAGER=more" >> /root/.profile && \
  echo "export PS1=\"🐳  \W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]\"" >> /root/.profile && \
  echo "alias ll='ls -lAh'" >> /root/.profile && \
  echo "alias l='ls -lah'" >> /root/.profile && \
  echo "alias dir='tree -d -L 1'" >> /root/.profile && \
  echo "alias rake='bundle exec rake'" >> /root/.profile
### END Development environment customizations ###

EXPOSE 3000

# Install dependencies:
RUN apk add --update --no-cache build-base git curl tree vim \
  && gem install bundler

ENV INSTALL_PATH /iglucose
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock* ./

# Bundle all gems
RUN bundle install

COPY . .

CMD [ "sh" ]
