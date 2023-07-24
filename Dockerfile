FROM ruby:3.1.1

RUN apt-get update -qq && apt-get install -y postgresql-client

RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./

COPY . .

ENTRYPOINT [ "./entrypoint.sh" ]
EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]