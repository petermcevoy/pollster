FROM ruby:1.9.3

RUN apt-get update -qq 
RUN apt-get install -y build-essential libpq-dev nodejs

ENV app /app

RUN mkdir $app
WORKDIR $app

ENV BUNDLE_PATH /box

RUN gem install bundler

ADD . $app

#CMD rails s -b 0.0.0.0
CMD ./script/start.sh