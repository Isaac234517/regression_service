FROM ruby:2.3
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN bundle install
CMD ["rails","s", "-p", "3000"]