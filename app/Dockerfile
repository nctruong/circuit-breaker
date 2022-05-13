FROM ruby:3.0.0
# Install node 14-LTS and yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN npm install -g yarn@1

WORKDIR /server
COPY . /server
RUN gem install bundler:2.3.13

# force ruby platform due to nokogiri in chip M1
RUN bundle config set force_ruby_platform true
RUN bundle install

EXPOSE 3000
RUN RAILS_ENV=production bundle exec rake assets:precompile
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]