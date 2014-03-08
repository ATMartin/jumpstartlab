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

	def self.delete(id)
		database.transaction do |db|
			db['ideas'].delete_at(id.to_i)
		end
	end

  def self.database
    @database ||= YAML::Store.new('ideabox')
  end

  def database
    Idea.database
  end

  def self.raw
    database.transaction do |db|
      db['ideas'] || []
    end
  end

  def self.all
    raw.map { |data| new(data) }
  end
	
	def self.find_raw(id)
		database.transaction do |db|
			db['ideas'].at(id)
		end
	end

	def self.find(id)
		new(Idea.find_raw(id))
	end

	def self.update(id, data)
		database.transaction do  |db|
			db['ideas'][id] = data
		end
	end
end
