require 'spec_helper'

describe "Creating TODO lists" do
	def create_todo_list(options={})
		options[:name] ||="My todo list"
		options[:description] ||= "This is what I'm doing today."

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")
		
		fill_in "Name", with: options[:name]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end
	
	it "redirects to the TODO index page on success" do
		create_todo_list
		expect(page).to have_content("My todo list")
	end

	it "displays an error when the TODO list has no name" do
		expect(TodoList.count).to eq(0)
		create_todo_list name: ""
		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the name isn't at least 3 characters long" do
		expect(TodoList.count).to eq(0)
		create_todo_list name: "Hi"
		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the TODO list has no description" do
		expect(TodoList.count).to eq(0)
		create_todo_list description: ""
		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end
	
	it "displays an error when the name isn't at least 5 characters long" do
		expect(TodoList.count).to eq(0)
		create_todo_list description: "Mine"
		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end
	
end
