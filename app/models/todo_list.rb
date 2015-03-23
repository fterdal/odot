class TodoList < ActiveRecord::Base
	validates :name, presence: true
	validates :name, length: { minimum: 3 }

	validates :description, presence: true
	validates :description, length: {  minimum: 5 }
end

