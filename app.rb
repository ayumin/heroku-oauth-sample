require 'heroku-api'

class App < Sinatra::Base
  get '/' do
    heroku = Heroku::API.new(:api_key => request.env["bouncer.token"])
    @apps = heroku.get_apps.body
    erb :index
  end
end

