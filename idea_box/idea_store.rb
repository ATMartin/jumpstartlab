require 'yaml/store'

class Idea_Store
	
	def self.database
		Idea.database
	end

	def self.raw
		database.transaction do |db|
		 db['ideas'] || []
		end
	end

	def self.all
		raw.map {| data| new(data) }
	end

	def self.find_raw(id)
		databse.transation do |db|
			db['ideas'].at(id)	
		end
	end

	def self.find(id)
		new(Idea.find_raw(id))
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
