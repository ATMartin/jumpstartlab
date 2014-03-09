require 'idea_box'

class IdeaBoxApp < Sinatra::Base
# Sinatra settings for Nitrous.IO
  set :bind, '0.0.0.0'
  set :port, 3000
  register Sinatra::Reloader
#------------------------- HELPERS

#------------------------- ROUTING
	set :method_override, true
	set :root, 'lib/app'

  get '/' do 
    erb :index, locals: {ideas: IdeaStore.all, idea: Idea.new}
  end

  post '/' do
    IdeaStore.create(params[:idea])
		redirect '/'
  end

	put '/:id' do |id|
		IdeaStore.update(id.to_i, params[:idea])
		redirect '/'
	end
	
	get '/:id/edit' do |id|
		idea = IdeaStore.find(id.to_i)
		erb :edit, locals: {id: id, idea: idea}
	end
	
	delete '/:id' do |id|
		IdeaStore.delete(id)
		redirect '/'	
	end

  not_found do
    erb :error
  end

  run! if app_file == $0
end
