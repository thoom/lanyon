Lanyon
======

Introduction
------------
[Lanyon](https://en.wikipedia.org/wiki/Strange_Case_of_Dr_Jekyll_and_Mr_Hyde) is a friend of Jekyll's. This Docker image provides a way to build a static website from 
a [Jekyll](https://jekyllrb.com)-based Git repository. The static website is then served by Nginx. 


Usage
-----

### Environment variables
Pass the following environment variables when instantiating the docker container:

#### SSH_KEY
Base64 encoded SSH private key used to connect to your Git repository.

#### GIT_REPO
The URL of the git repository.

#### GIT_BRANCH
The branch to use (defaults to master if not passed).

### Git repository
Your repository must include a `Gemfile` or `Gemfile.lock` to install any Ruby dependencies.
