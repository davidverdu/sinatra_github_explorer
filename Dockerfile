FROM ruby:2.6.0
ENV LANG C.UTF-8

#Cache bundle install
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install

ENV APP_ROOT /workspace
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT

ENV RACK_ENV production

RUN echo "set :bind, '0.0.0.0'" >> $APP_ROOT/server.rb
#RUN echo "set :environment, :production" >> $APP_ROOT/server.rb

EXPOSE 4567

CMD ["ruby", "server.rb"]