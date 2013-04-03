class App < Sinatra::Base
  get '/' do
    heroku = Heroku::API.new(:api_key => request.env["bouncer.token"])
    @apps = heroku.get_apps
    erb :index
  end
end

