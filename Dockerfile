FROM ruby:3.0.0

RUN apt-get update && apt-get install -y vim

WORKDIR /teste-delivery-center/

COPY . /teste-delivery-center/

RUN gem install bundler -v 2.2.14 --no-document

RUN bundle install

COPY . .

EXPOSE 3002

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3002"]
