require 'sinatra'
require 'sinatra/reloader'
set :bind, '0.0.0.0'
set :port, '3000'

num_secret = rand(101)


#---------HELPER METHODS
def compare(int1, int2)
	threshold = 5  # difference between "bigger" and "way bigger"
	comparison = int1 - int2
	if comparison == 0
		return 0
	elsif comparison > 0 && comparison < threshold
		return 1
	elsif comparison >= threshold
		return 2
	elsif comparison < 0 && comparison.abs < threshold
		return -1
	elsif comparison < 0 && comparison.abs >= threshold
		return -2
	else
		return nil
	end
end

#---------REQUEST HANDLING
get '/' do
	"Hello, World!"
end

get '/guesser' do
	compare_nums = !params['guess'].nil? ? compare(params['guess'].to_i, num_secret) : nil 
	erb :index, :locals => { :number => num_secret, :compared => compare_nums }
end
