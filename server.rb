require 'sinatra'
require File.expand_path("#{File.dirname(__FILE__)}/models/github_repository")

#Homepage handler
get '/' do
  erb :'index.html'
end

#search results handler
post '/search' do
  @repositories = GithubRepository.search(params[:query])
  erb :'index.html'
end

