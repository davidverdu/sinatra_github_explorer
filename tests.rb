ENV['APP_ENV'] = 'test'

require './server'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

describe 'The Explore GitHub web App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "homepage works" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to match("Search!")
    #expect(last_response.body).to
  end

  it "perform a Ruby search" do
    post '/search', {query: 'ruby'}
    expect(last_response).to be_ok
    expect(last_response.body).to match("Search results...")
  end

  it "perform a Rails search" do
    post '/search', {query: 'ruby rails'}
    expect(last_response).to be_ok
    expect(last_response.body).to match("Search results...")
    expect(last_response.body).to match("rails/rails")
  end

  it "perform a bad search" do
    post '/search', {query: 'veryBadSearchTernToNotFindResults'}
    expect(last_response).to be_ok
    expect(last_response.body).to match("No results found")
  end

  it "perform an empty search" do
    post '/search', {query: ''}
    expect(last_response).to be_ok
    expect(last_response.body).not_to match("Search results...")
  end

end

describe 'The GithubRepository model' do
  it 'search Ruby repositories' do
    repositories = GithubRepository.search("ruby")
    expect(repositories).not_to be_empty
    expect(repositories.length).to eq(30)
    expect(repositories.first.name).not_to be_empty
  end

  it 'search Rails repositories' do
    repositories = GithubRepository.search("ruby rails")
    expect(repositories).not_to be_empty
    expect(repositories.length).to eq(30)
    expect(repositories.first.name).not_to be_empty
    expect(repositories.first.name).to match("rails")
  end

  it 'search Python Pandas repositories' do
    repositories = GithubRepository.search("python pandas")
    expect(repositories).not_to be_empty
    expect(repositories.length).to eq(30)
    expect(repositories.first.name).to match("pandas")
  end

  it 'perform a bad search' do
    repositories = GithubRepository.search("veryBadSearchTernToNotFindResults")
    expect(repositories).to be_empty
  end

  it 'perform an empty search' do
    repositories = GithubRepository.search("")
    expect(repositories).to be_empty
  end
end