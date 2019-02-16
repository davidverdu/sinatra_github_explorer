require 'rest-client'
require 'json'

class GithubRepository

  #repository attributes stored in the class with their setters and getters (GitHub API returns a lot of fields)
  DESIRED_FIELDS = %w(name full_name html_url description fork created_at updated_at pushed_at git_url clone_url language)
  attr_accessor *DESIRED_FIELDS.map {|field| field.to_sym }

  #constructor takes a hash parsed from JSON response to assign its attributes
  def initialize(hash={})
    hash.each_pair do |key,value|
      send("#{key}=".to_sym,value) if DESIRED_FIELDS.include?(key)
    end
  end

  #class method to search repositories using GitHub REST API
  def self.search(query)
    repositories = []
    return [] if query.empty?

    #GitHub API URL with the query
    url = 'https://api.github.com/search/repositories?sort=stars&order=desc&q='
    url = URI.escape(url + query.gsub(' ','+'))

    try_times = 0 #counter of times I try to obtain info from GitHub API
    begin
      #Get API JSON response
      response = RestClient.get(url)
      #parse response into a Hash
      parsed_response = JSON.parse(response)

      #convert array of hashes into an array of GithubRepository objects
      repositories = parsed_response['items'].map { |hash| GithubRepository.new(hash) }
    rescue
      #retry block up to 5 times just in case of a network exception
      try_times += 1
      retry if try_times <= 5
    end

    #return found repositories
    repositories
  end

end
