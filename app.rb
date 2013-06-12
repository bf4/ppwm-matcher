require 'logger'
require 'sinatra'
require 'sinatra_auth_github'
require 'sinatra/activerecord'
require './models/code'

module PpwmMatcher
  class App < Sinatra::Base
    Pair = Struct.new(:code1,:code2) do
      def match(code)
        (code1 == code && code2) ||
          (code2 == code && code1)
      end
    end
    Pairs = Struct.new(:pairs) do
      def find_match(code)
        pairs.each do |pair|
          match = pair.match(code)
          return match unless match.nil?
        end
        'none'
      end
    end
    CODES = Pairs.new([
    Pair.new('foo','bar')
  ])
    UNPAIRED = Class.new
    MATCHED_PAIRS = {}
    enable :sessions

    set :github_options, {
      :scopes    => "user",
      :secret    => ENV['GITHUB_CLIENT_SECRET'],
      :client_id => ENV['GITHUB_CLIENT_ID'],
    }
    LOGGER = Logger.new(STDOUT)

    register Sinatra::Auth::Github

    helpers do
      def repos
        github_request("user/repos")
      end
    end

    get '/' do
      authenticate!
      <<-PAIR
Hello there, #{github_user.login}!
Enter your code:
<form action='/code' method='POST'>
  <input type='text' name='code' value=''>
  <input type='submit'>
</form>
PAIR
    end

    post '/code' do
      authenticate!
      code = params['code']
      #TODO don't over-write any already posted codes willy-nilly
      # check if this is the same user using the same code twice
      user_info = "#{github_user.login}, #{github_user.email}"
      MATCHED_PAIRS[code] = user_info
      LOGGER.info "Matched #{user_info} to #{code}"
      pair = MATCHED_PAIRS.fetch(CODES.find_match(code), UNPAIRED)
      if pair == UNPAIRED
        message = "Your pair hasn't signed in yet, keep your fingers crossed!"
      else
        message = "Your pair is #{pair}! Click here to send an email and set up a pairing session! Don't be shy!"
      end
      <<-PAIR
You submitted code #{code}<br>
#{message}
PAIR
    end

    get '/orgs/:id' do
      github_organization_authenticate!(params['id'])
      "Hello There, #{github_user.name}! You have access to the #{params['id']} organization."
    end

    get '/publicized_orgs/:id' do
      github_publicized_organization_authenticate!(params['id'])
      "Hello There, #{github_user.name}! You are publicly a member of the #{params['id']} organization."
    end

    get '/teams/:id' do
      github_team_authenticate!(params['id'])
      "Hello There, #{github_user.name}! You have access to the #{params['id']} team."
    end

    get '/logout' do
      logout!
      redirect 'https://github.com'
    end
  end
end
