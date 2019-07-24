#FROM phusion/passenger-ruby23:latest
FROM tvudocker/tuansblog_20_7_19
MAINTAINER Tuan Vu
#ENV HOME /root
#USER root
ENV APP_HOME /home/app/webapp
ENV SECRET_KEY_BASE efe567a36b1d63fa275089e11665080b0aa0bdda46b35da28ec55ce46685c616db4d722d4077c1660937f0e93b96cd059ae9cd946a0221fed2fe628eeef9897d
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

EXPOSE 80
EXPOSE 443
EXPOSE 8888

RUN rm -f /etc/service/nginx/down

# Configure Nginx
RUN rm /etc/nginx/sites-enabled/default
ADD docker/netapp.conf /etc/nginx/sites-enabled/netapp.conf
#ADD docker/configs/nginx-rails-env.conf /etc/nginx/main.d/rails-env.conf

# Install the app
RUN mkdir $APP_HOME
#COPY Gemfile  $APP_HOME
#COPY Gemfile.lock $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN chown -R app:app $APP_HOME

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN apt-get update && apt-get install -y libicu-dev && apt-get install -y libmagickwand-dev

RUN apt-get install -y tzdata
RUN gem install bundler
RUN apt-get install libgmp-dev
RUN gem install rmagick -v '2.15.4'
RUN gem install passenger -v '5.1.7'
RUN gem install bcrypt


#RUN bundle install --binstubs --deployment --without test development
RUN bundle install
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

 
#CMD tail -f /dev/null

