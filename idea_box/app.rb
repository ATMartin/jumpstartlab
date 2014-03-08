require './idea.rb'

class IdeaBoxApp < Sinatra::Base
# Sinatra settings for Nitrous.IO
  set :bind, '0.0.0.0'
  set :port, 3000
  register Sinatra::Reloader
#------------------------- HELPERS

#------------------------- ROUTING
	set :method_override, true

  get '/' do 
    erb :index, locals: {ideas: Idea.all, idea: Idea.new}
  end

  post '/' do
    idea = Idea.new(params[:idea])
    idea.save
    redirect '/'
  end

	put '/:id' do |id|
		Idea.update(id.to_i, params[:idea])
		redirect '/'
	end
	
	get '/:id/edit' do |id|
		idea = Idea.find(id.to_i)
		erb :edit, locals: {id: id, idea: idea}
	end
	
	delete '/:id' do |id|
		Idea.delete(id)
		# 2. Check for duplicate entries?
		# 3. Return "true" if removed or "false" for an error. 
		redirect '/'	
		"DELETING this idea!"
	end

  not_found do
    erb :error
  end

  run! if app_file == $0
end
