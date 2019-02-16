# sinatra_github_explorer
A web application written in Ruby to explore GitHub repositories by using their public API

## Run as a docker container

First, create the image from the Dockerfile in the project directory:
```
docker image build -t github_explorer .
```

Then, run the container binding the port 4567
```
docker run -p 4567:4567 github_explorer
```

Finally, browse with your navigator http://localhost:4567

## Run in your host without Docker

First, you need to install Ruby 2.6.0, for example, by using a Ruby Version Manager like 
[rbenv](https://github.com/rbenv/rbenv rbenv) or [rvm](https://github.com/rvm/rvm rvm). You can have
a look to my [tutorial](https://github.com/davidverdu/rails_tutorial/tree/master/01_install_ruby tutorial) to
install Ruby in Ubuntu with rbenv.

Then, go to the project folder and install gems:
```
bundle install
```

Finally, run the application server with this command:
```
ruby server.rb
```

Puma web server will be launched and listen to port 4567

## Run tests

Go to project folder, both locally or inside the container, and run RSpec
```
rspec tests.rb
```

