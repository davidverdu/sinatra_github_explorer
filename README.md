# Sinatra GitHub Explorer
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
[rbenv](https://github.com/rbenv/rbenv) or [rvm](https://github.com/rvm/rvm). You can have
a look to my [tutorial](https://github.com/davidverdu/rails_tutorial/tree/master/01_install_ruby) to
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
## Developing

The code follows this structure:

* server.rb: is the Ruby server application run by Sinatra
* models folder: contains the model classes
* views: contains the ERB view templates of the appication
* scss: contains the SCSS stylesheet source files. They will be transformed into css files in public folder
* public: contains the static files served to the browser, such as minimized CSS, javascripts, images, fonts.
* tests.rb: contains the RSpec tests for this application
* Gemfile: contains Ruby gem dependencies
* package.json: Node.js dependencies
* gulpfile.js: contains Gulp task definitions, such as gulp css
* Dockerfile: contains Docker container definition, ready to run in production

To generate CSS files in public folder out of the SCSS sources run:
```
npm install
gulp css
```
(please note that you will be required to install node.js and npm to run this)
