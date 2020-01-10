FROM ruby:2.5.3
# https://github.com/nodesource/distributions#installation-instructions
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs
RUN apt-get update && apt-get install -y mysql-client sqlite3 vim --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

#rake secret
    ENV SECRET_KEY_BASE d5965c40cc27cadb5f9e92b34baa7990f8ae3aafb17f16cc32ef1777fdaa5447073e570445a9d3650f4ca923a3ddf2de24f804b2b580c588f871f974ef018043
# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]