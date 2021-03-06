#!/bin/sh

cd /var/www

# Dont pull code down if the .git folder exists
if [ ! -d ".git" ]; then

  # Disable Strict Host checking for non interactive git clones
  mkdir -p -m 0700 /root/.ssh
  echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

 if [ ! -z "$SSH_KEY" ]; then
  echo $SSH_KEY > /root/.ssh/id_rsa.base64
  base64 -d /root/.ssh/id_rsa.base64 > /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
 fi

 # Pull down code from git for our site!
 if [ ! -z "$GIT_REPO" ]; then
   # Remove the test index file
   rm -Rf /var/www/*
   if [ ! -z "$GIT_BRANCH" ]; then
     git clone -b $GIT_BRANCH $GIT_REPO /var/www
   else
     git clone $GIT_REPO /var/www
   fi
   
   if [ ! -f "Gemfile" ]; then
     echo "missing Gemfile"
     exit 1  
   fi

   bundle install --without=development
   jekyll build
 fi
fi

# Always chown webroot for better mounting
chown -Rf nginx.nginx /var/www

# Start nginx
nginx -g "daemon off;"