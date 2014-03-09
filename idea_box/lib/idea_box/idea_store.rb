require 'yaml/store'

class IdeaStore
	
	def self.database
		@database ||= YAML::Store.new('db/ideabox')
	end
	
	def self.create(data)
		database.transaction do |db|
			db['ideas'] ||= []
			db['ideas'] << data
		end
	end

	def self.raw
		database.transaction do |db|
		 db['ideas'] || []
		end
	end

	def self.all
		raw.map {|data| Idea.new(data) }
	end

	def self.find_raw(id)
		database.transaction do |db|
			db['ideas'].at(id)	
		end
	end

	def self.find(id)
		Idea.new(IdeaStore.find_raw(id))
	end
	
	def self.update(id, data)
		database.transaction do |db|
			db['ideas'][id] = data
		end
	end

	def self.delete(id)
		database.transaction do |db|
			db['ideas'].delete_at(id.to_i)
		end
	end
end
