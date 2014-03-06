require 'sinatra'
require 'sinatra/reloader'
set :bind, '0.0.0.0'
set :port, '3000'

num_secret = rand(101)

get '/' do
	"Hello, World!"
end

get '/guesser' do
	# "The secret number is #{num_secret}!"
	erb :index, :locals => { :number => num_secret }
end
