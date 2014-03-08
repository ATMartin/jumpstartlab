require 'yaml/store'

class Idea
  
  attr_reader :title, :description

  def initialize(title, description)
    @title = title
    @description = description
  end

  def save
    database.transaction do |db|
      db['ideas'] ||= []
      db['ideas'] << {title: @title, description: @description}
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
    raw.map { |data| new(data[:title], data[:description]) } 
  end
	
	def self.find_raw(id)
		database.transaction do |db|
			db['ideas'].at(id)
		end
	end

	def self.find(id)
		str_raw = Idea.find_raw(id)
		new(str_raw[:title], str_raw[:description])
	end

	def self.update(id, data)
		database.transaction do  |db|
			db['ideas'][id] = (data)
		end
	end
end
