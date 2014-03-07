require './idea.rb'

class IdeaBoxApp < Sinatra::Base
# Sinatra settings for Nitrous.IO
  set :bind, '0.0.0.0'
  set :port, 3000
  configure :development do register Sinatra::Reloader end
#------------------------- HELPERS

#------------------------- ROUTING
  get '/' do 
    erb :index, locals: {ideas: Idea.all} 
  end

  post '/' do
    idea = Idea.new(params['idea_title'], params['idea_description'])
    idea.save
    redirect '/'
  end

  not_found do
    erb :error
  end

  run! if app_file == $0
end
