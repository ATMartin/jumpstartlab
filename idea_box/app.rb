require 'bundler'
Bundler.require

class IdeaBoxApp < Sinatra::Base
# Sinatra settings for Nitrous.IO
  set :bind, '0.0.0.0'
  set :port, 3000

#------------------------- HELPERS

#------------------------- ROUTING
  get '/' do 
    "Hello, world!"
  end

  run! if app_file == $0
end