require 'yaml/store'

class Idea
  
  attr_reader :title, :description

  def initialize(h_idea = {})  
		@title = h_idea['title']
    @description = h_idea['description']
	end

  def save
    database.transaction do |db|
      db['ideas'] ||= []
      db['ideas'] << {'title' => @title, 'description' => @description}
    end
  end

  def database
    IdeaStore.database
  end

end
