class TodoList < ActiveRecord::Base
	validates :name, presence: true
	validates :name, length: { minimum: 3 }
end

