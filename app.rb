require 'heroku-api'

class App < Sinatra::Base
  helpers do
  	def api
  	  halt(401) unless request.env["bouncer.token"]
  	  Heroku::API.new(:api_key => request.env["bouncer.token"])
  	end
  end

  before do
    if request.env['bouncer.user']
      @user = request.env['bouncer.user']
    end
  end

  get '/' do
    @apps = api.get_apps.body
    erb :index
  end

  error Heroku::API::Errors::Unauthorized do
    session[:return_to] = request.url
    redirect to('/auth/heroku')
  end
end

